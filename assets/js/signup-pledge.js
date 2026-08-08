// SAP 서약 동의 및 직접 서명 캔버스.
const SAP_PLEDGE_VERSION = 'sap-pledge-v1';
let signupPledgeStrokes = [];
let signupPledgeCurrentStroke = null;

function signupPledgeCanvas() {
  return document.getElementById('pledge-signature-canvas');
}

function drawSignupPledgeSignature() {
  const canvas = signupPledgeCanvas();
  if (!canvas) return;
  const rect = canvas.getBoundingClientRect();
  const ratio = window.devicePixelRatio || 1;
  const width = Math.max(1, Math.round(rect.width * ratio));
  const height = Math.max(1, Math.round(rect.height * ratio));
  if (canvas.width !== width || canvas.height !== height) {
    canvas.width = width;
    canvas.height = height;
  }
  const ctx = canvas.getContext('2d');
  ctx.clearRect(0, 0, width, height);
  ctx.lineCap = 'round';
  ctx.lineJoin = 'round';
  ctx.strokeStyle = '#1c1b1b';
  ctx.lineWidth = 2.2 * ratio;
  signupPledgeStrokes.forEach((stroke) => {
    if (!stroke.length) return;
    ctx.beginPath();
    stroke.forEach((point, index) => {
      const x = point.x * width;
      const y = point.y * height;
      if (index === 0) ctx.moveTo(x, y);
      else ctx.lineTo(x, y);
    });
    ctx.stroke();
  });
}

function signupPledgePoint(event) {
  const canvas = signupPledgeCanvas();
  const rect = canvas.getBoundingClientRect();
  return {
    x: Math.max(0, Math.min(1, (event.clientX - rect.left) / rect.width)),
    y: Math.max(0, Math.min(1, (event.clientY - rect.top) / rect.height))
  };
}

function signupPledgePointerDown(event) {
  const canvas = signupPledgeCanvas();
  canvas.setPointerCapture(event.pointerId);
  signupPledgeCurrentStroke = [signupPledgePoint(event)];
  signupPledgeStrokes.push(signupPledgeCurrentStroke);
  drawSignupPledgeSignature();
}

function signupPledgePointerMove(event) {
  if (!signupPledgeCurrentStroke) return;
  const point = signupPledgePoint(event);
  const previous = signupPledgeCurrentStroke[signupPledgeCurrentStroke.length - 1];
  if (Math.hypot(point.x - previous.x, point.y - previous.y) < 0.003) return;
  if (signupPledgeStrokes.reduce((sum, stroke) => sum + stroke.length, 0) >= 600) return;
  signupPledgeCurrentStroke.push(point);
  drawSignupPledgeSignature();
}

function signupPledgePointerUp() {
  signupPledgeCurrentStroke = null;
  const hint = document.getElementById('pledge-signature-hint');
  if (hint && signupPledgeStrokes.some((stroke) => stroke.length > 1)) hint.classList.add('hidden');
}

function clearSignupPledgeSignature() {
  signupPledgeStrokes = [];
  signupPledgeCurrentStroke = null;
  drawSignupPledgeSignature();
}

function validateSignupPledge() {
  const checks = [...document.querySelectorAll('[data-pledge-item]')];
  const allChecked = checks.length === 7 && checks.every((input) => input.checked);
  const signerName = document.getElementById('pledge-name-input').value.trim();
  const hasSignature = signupPledgeStrokes.some((stroke) => stroke.length > 1);
  document.getElementById('pledge-agreement-hint').classList.toggle('hidden', allChecked);
  document.getElementById('pledge-name-hint').classList.toggle('hidden', !!signerName);
  document.getElementById('pledge-signature-hint').classList.toggle('hidden', hasSignature);
  return allChecked && !!signerName && hasSignature;
}

function getSignupPledgeData() {
  return {
    pledge_version: SAP_PLEDGE_VERSION,
    pledge_signer_name: document.getElementById('pledge-name-input').value.trim(),
    pledge_agreed_items: [1, 2, 3, 4, 5, 6, 7],
    pledge_signature: signupPledgeStrokes.map((stroke) => stroke.map((point) => ({
      x: Number(point.x.toFixed(4)), y: Number(point.y.toFixed(4))
    }))),
    pledge_signed_at: new Date().toISOString()
  };
}

function initSignupPledge() {
  const canvas = signupPledgeCanvas();
  if (!canvas) return;
  canvas.addEventListener('pointerdown', signupPledgePointerDown);
  canvas.addEventListener('pointermove', signupPledgePointerMove);
  canvas.addEventListener('pointerup', signupPledgePointerUp);
  canvas.addEventListener('pointercancel', signupPledgePointerUp);
  document.getElementById('pledge-signature-clear')?.addEventListener('click', clearSignupPledgeSignature);
  new ResizeObserver(drawSignupPledgeSignature).observe(canvas);
  drawSignupPledgeSignature();
}

window.initSignupPledge = initSignupPledge;
window.validateSignupPledge = validateSignupPledge;
window.getSignupPledgeData = getSignupPledgeData;
