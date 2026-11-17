import { version } from 'next/package.json';
export const dynamic = 'force-dynamic';

export function GET() {
  return Response.json({
    slot: process.env.SLOT,
    fixture: process.env.BUILD_LABEL,
    nextVersion: version,
  });
}
