# Stage 1: Build file JAR bằng Gradle Wrapper (Dùng Java 21)
FROM eclipse-temurin:21-jdk-alpine AS builder
WORKDIR /workspace

# Copy toàn bộ code vào
COPY . .

# Cấp quyền cho gradlew và tiến hành build riêng thư mục 'app'
RUN chmod +x ./gradlew
RUN ./gradlew :app:jar --no-daemon

# Stage 2: Chạy ứng dụng bằng JRE siêu nhẹ (Dùng Java 21)
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app

# Lấy file jar đã build ở Stage 1 sang Stage 2
COPY --from=builder /workspace/app/build/libs/*.jar app.jar

EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
