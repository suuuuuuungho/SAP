// Supabase Free Plan에는 Storage Image Transformations가 없으므로 업로드 전에 브라우저에서
// 직접 리사이즈/압축한다. 긴 변 1600px이면 문서 글씨를 확인하면서도 휴대폰 원본보다 훨씬 작다.
async function optimizeImageForUpload(file, options = {}) {
  if (!file || !String(file.type || '').startsWith('image/')) return file;
  if (file.type === 'image/gif' || file.type === 'image/svg+xml') return file;

  const maxDimension = Number(options.maxDimension) || 1600;
  const quality = Number(options.quality) || 0.8;
  let source = null;
  let objectUrl = '';

  try {
    if ('createImageBitmap' in window) {
      try {
        source = await createImageBitmap(file, { imageOrientation: 'from-image' });
      } catch (_) {
        source = await createImageBitmap(file);
      }
    } else {
      objectUrl = URL.createObjectURL(file);
      source = await new Promise((resolve, reject) => {
        const image = new Image();
        image.onload = () => resolve(image);
        image.onerror = reject;
        image.src = objectUrl;
      });
    }

    const width = source.width || source.naturalWidth;
    const height = source.height || source.naturalHeight;
    if (!width || !height) return file;
    const scale = Math.min(1, maxDimension / Math.max(width, height));
    const targetWidth = Math.max(1, Math.round(width * scale));
    const targetHeight = Math.max(1, Math.round(height * scale));
    const canvas = document.createElement('canvas');
    canvas.width = targetWidth;
    canvas.height = targetHeight;
    const context = canvas.getContext('2d');
    context.imageSmoothingEnabled = true;
    context.imageSmoothingQuality = 'high';
    context.drawImage(source, 0, 0, targetWidth, targetHeight);

    const blob = await new Promise((resolve) => canvas.toBlob(resolve, 'image/webp', quality));
    if (!blob || blob.size >= file.size) return file;
    const baseName = String(file.name || 'photo').replace(/\.[^.]+$/, '');
    return new File([blob], `${baseName}.webp`, { type: 'image/webp', lastModified: Date.now() });
  } catch (error) {
    console.warn('[image-utils] 원본 이미지를 사용합니다.', error);
    return file;
  } finally {
    if (source && typeof source.close === 'function') source.close();
    if (objectUrl) URL.revokeObjectURL(objectUrl);
  }
}

window.optimizeImageForUpload = optimizeImageForUpload;
