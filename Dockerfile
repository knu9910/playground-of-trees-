# 멀티 스테이지 빌드를 위한 베이스 이미지
FROM node:20-alpine AS base

# pnpm 설치
RUN corepack enable && corepack prepare pnpm@latest --activate

# 의존성 설치 스테이지
FROM base AS deps
WORKDIR /app

# pnpm-lock.yaml과 package.json 복사
COPY pnpm-lock.yaml package.json ./

# 의존성 설치
RUN pnpm install --frozen-lockfile

# 빌드 스테이지
FROM base AS builder
WORKDIR /app

# 의존성 복사
COPY --from=deps /app/node_modules ./node_modules
COPY . .

# 환경 변수 설정
ENV NEXT_TELEMETRY_DISABLED 1
ENV NODE_ENV production

# 애플리케이션 빌드
RUN pnpm build

# 프로덕션 스테이지
FROM node:20-alpine AS runner
WORKDIR /app

# 시스템 사용자 생성
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

# Next.js standalone 출력 디렉토리 복사
COPY --from=builder /app/public ./public

# Next.js standalone 출력에서 필요한 파일들만 복사
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static

# 사용자 변경
USER nextjs

# 포트 노출
EXPOSE 3000

# 환경 변수 설정
ENV PORT 3000
ENV HOSTNAME "0.0.0.0"
ENV NODE_ENV production
ENV NEXT_TELEMETRY_DISABLED 1

# 애플리케이션 실행
CMD ["node", "server.js"] 