import type { Metadata } from 'next';
import './globals.css';

export const metadata: Metadata = {
  title: '나무의 놀이터',
  description: '나무의 놀이터',
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="ko">
      <body className={``}>{children}</body>
    </html>
  );
}
