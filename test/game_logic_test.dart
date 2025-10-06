import 'package:test/test.dart';

void main() {
  group('Pika Jump Game Logic Tests', () {
    test('Barrier recycling logic', () {
      // Simulate barrier position
      double barrierX = 2.0;
      
      // Move barrier left (simulating game loop)
      for (int i = 0; i < 700; i++) {
        barrierX -= 0.005;
        
        // Recycle when off screen
        if (barrierX < -1.5) {
          barrierX += 3.5;
        }
      }
      
      // Barrier should be recycled and visible
      expect(barrierX, greaterThan(-1.5));
      expect(barrierX, lessThan(2.5));
    });
    
    test('Score increments only when passing barriers', () {
      int score = 0;
      double barrierX = 0.2;
      double birdWidth = 0.1;
      bool barrierPassed = false;
      
      // Before passing
      if (barrierX < -birdWidth && !barrierPassed) {
        barrierPassed = true;
        score++;
      }
      expect(score, equals(0));
      
      // Move barrier past bird
      barrierX = -0.2;
      if (barrierX < -birdWidth && !barrierPassed) {
        barrierPassed = true;
        score++;
      }
      expect(score, equals(1));
      expect(barrierPassed, isTrue);
      
      // Barrier continues moving, score should not increment again
      barrierX = -0.5;
      if (barrierX < -birdWidth && !barrierPassed) {
        barrierPassed = true;
        score++;
      }
      expect(score, equals(1));
    });
    
    test('Boundary collision detection', () {
      double birdY;
      
      // Test top boundary
      birdY = -1.1;
      expect(birdY < -1 || birdY > 1, isTrue);
      
      // Test bottom boundary
      birdY = 1.1;
      expect(birdY < -1 || birdY > 1, isTrue);
      
      // Test valid position
      birdY = 0.0;
      expect(birdY < -1 || birdY > 1, isFalse);
    });
    
    test('Barrier collision detection - X axis', () {
      double barrierX = 0.0;
      double barrierWidth = 0.5;
      double birdWidth = 0.1;
      
      // Bird in collision range
      bool inCollisionRange = barrierX <= birdWidth && 
                              barrierX + barrierWidth >= -birdWidth;
      expect(inCollisionRange, isTrue);
      
      // Bird past barrier
      barrierX = -1.0;
      inCollisionRange = barrierX <= birdWidth && 
                         barrierX + barrierWidth >= -birdWidth;
      expect(inCollisionRange, isFalse);
      
      // Bird before barrier
      barrierX = 1.0;
      inCollisionRange = barrierX <= birdWidth && 
                         barrierX + barrierWidth >= -birdWidth;
      expect(inCollisionRange, isFalse);
    });
    
    test('Barrier collision detection - Y axis', () {
      double birdY = 0.5;
      double birdHeight = 0.1;
      double topBarrierHeight = 0.6;
      double bottomBarrierHeight = 0.4;
      
      // Bird in safe zone
      bool hitTop = birdY <= -1 + topBarrierHeight;
      bool hitBottom = birdY + birdHeight >= 1 - bottomBarrierHeight;
      expect(hitTop || hitBottom, isFalse);
      
      // Bird hits top barrier
      birdY = -0.5;
      hitTop = birdY <= -1 + topBarrierHeight;
      expect(hitTop, isTrue);
      
      // Bird hits bottom barrier
      birdY = 0.6;
      hitBottom = birdY + birdHeight >= 1 - bottomBarrierHeight;
      expect(hitBottom, isTrue);
    });
    
    test('Jump physics', () {
      double time = 0.0;
      double gravity = -4.9;
      double velocity = 3.5;
      double height;
      
      // At t=0, height should be 0
      height = gravity * time * time + velocity * time;
      expect(height, equals(0.0));
      
      // At t=0.1, bird should move up
      time = 0.1;
      height = gravity * time * time + velocity * time;
      expect(height, greaterThan(0.0));
      
      // Eventually bird falls down
      time = 1.0;
      height = gravity * time * time + velocity * time;
      expect(height, lessThan(0.0));
    });
    
    test('Best score tracking', () {
      int score = 5;
      int bestScore = 3;
      
      // Update best score
      bestScore = score > bestScore ? score : bestScore;
      expect(bestScore, equals(5));
      
      // Best score should not decrease
      score = 2;
      bestScore = score > bestScore ? score : bestScore;
      expect(bestScore, equals(5));
    });
  });
}
