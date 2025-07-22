// Animasi Menjelajahi Budaya Makanan Indonesia
// Multi-Scene Animation

int currentScene = 1;
int totalScenes = 8;

// Variabel untuk gambar
PImage guruImg, chefImg, murid1Img, murid2Img, murid3Img;
PImage rendangImg, gudegImg, cotoImg, papedaImg;
PImage kelasImg, dapurImg, papanTulisImg;
PImage pisangijoImg;
boolean imagesLoaded = false;

// Scene 1 variables
float bellSwing = 0;
boolean isRinging = false;
int ringCount = 0;
int maxRings = 3;
float ringTimer = 0;
float bellX, bellY;


// Scene 2 variables
float teacherArmAngle = 0;
float[] studentBlink = {0, 0, 0};
int[] blinkTimer = {0, 0, 0};

// Scene 3 variables
float chefWalkX = -100;
boolean chefWalking = true;

// Scene 4 variables - Chef Introduction
float chefIntroTimer = 0;
int introStep = 0;
String[] introTexts = {
  "Halo anak-anak!",
  "Saya Chef Budi",
  "Ahli masakan tradisional Indonesia",
  "Hari ini saya akan mengajarkan",
  "4 masakan khas dari berbagai daerah"
};



// Scene 5 Modern Kitchen variables
float modernKitchenTimer = 0;
float ingredientFloatY = 0;
float steamEffect = 0;
ArrayList<FloatingParticle> floatingParticles = new ArrayList<FloatingParticle>();

// Scene 6 Traditional Kitchen variables
float traditionalKitchenTimer = 0;
float gudegFloatY = 0;
float traditionalSteamEffect = 0;
ArrayList<TraditionalParticle> traditionalParticles = new ArrayList<TraditionalParticle>();

// Scene 7 Rustic Industrial Kitchen variables
float rusticKitchenTimer = 0;
float papedaFloatY = 0;
float rusticSteamEffect = 0;
ArrayList<RusticParticle> rusticParticles = new ArrayList<RusticParticle>();





// ===== SCENE 5: MODERN KITCHEN FRONT VIEW =====

class FloatingParticle {
  float x, y, vx, vy, life, maxLife;
  color particleColor;
  
  FloatingParticle(float x, float y, color c) {
    this.x = x;
    this.y = y;
    this.vx = random(-1, 1);
    this.vy = random(-2, -0.5);
    this.life = 255;
    this.maxLife = 255;
    this.particleColor = c;
  }
  
  void update() {
    x += vx;
    y += vy;
    life -= 3;
    vy *= 0.98;
  }
  
  void display() {
    if (life > 0) {
      float alpha = map(life, 0, maxLife, 0, 255);
      fill(red(particleColor), green(particleColor), blue(particleColor), alpha);
      noStroke();
      ellipse(x, y, 4, 4);
    }
  }
  
  boolean isDead() {
    return life <= 0;
  }
}

void drawModernKitchenFrontView() {
  // Background gradient modern
  for (int i = 0; i < height; i++) {
    float inter = map(i, 0, height, 0, 1);
    color c = lerpColor(color(240, 245, 250), color(220, 230, 240), inter);
    stroke(c);
    line(0, i, width, i);
  }
  
  // Lantai modern dengan pattern
  fill(180, 190, 200);
  stroke(160, 170, 180);
  strokeWeight(2);
  for (int i = 0; i < width; i += 40) {
    line(i, height - 100, i, height);
  }
  
  // Dinding dengan wallpaper modern
  fill(250, 248, 245);
  stroke(240, 238, 235);
  strokeWeight(1);
  rect(0, 0, width, height - 100);
  
  // Pattern dinding subtle
  stroke(230, 228, 225);
  strokeWeight(0.5);
  for (int i = 0; i < width; i += 60) {
    for (int j = 0; j < height - 100; j += 60) {
      point(i, j);
    }
  }
  
  // Kabinet atas modern
  fill(45, 45, 45);
  stroke(35, 35, 35);
  strokeWeight(2);
  rect(50, 50, width - 100, 80, 10);
  
  // Handle kabinet
  fill(200, 200, 200);
  stroke(180, 180, 180);
  strokeWeight(1);
  for (int i = 0; i < 4; i++) {
    rect(80 + i * 120, 85, 60, 4, 2);
  }
  
  // Kabinet bawah
  fill(50, 50, 50);
  stroke(40, 40, 40);
  strokeWeight(2);
  rect(50, height - 200, width - 100, 100, 10);
  
  // Counter top modern
  fill(220, 220, 220);
  stroke(200, 200, 200);
  strokeWeight(3);
  rect(50, height - 220, width - 100, 20, 5);
  
  // Backsplash
  fill(240, 240, 240);
  stroke(220, 220, 220);
  strokeWeight(1);
  rect(50, 130, width - 100, 90);
  
  // Pattern backsplash
  stroke(200, 200, 200);
  strokeWeight(0.5);
  for (int i = 0; i < width - 100; i += 20) {
    for (int j = 0; j < 90; j += 20) {
      point(50 + i, 130 + j);
    }
  }
}

void drawChefWithImage() {
  // Chef dengan gambar chef.png seperti di scene 4
  float chefX = width/2;
  float chefY = height/2; // Pindah ke tengah-tengah layar
  
  // Update animasi
  modernKitchenTimer += 0.05;
  
  if (imagesLoaded && chefImg != null) {
    imageMode(CENTER);
    pushMatrix();
    translate(chefX, chefY);
    
    // Slight movement untuk animasi
    float chefBob = sin(modernKitchenTimer * 2) * 2;
    translate(0, chefBob);
    
    // Slight rotation untuk efek hidup
    float chefRotate = sin(modernKitchenTimer * 1.5) * 0.02;
    rotate(chefRotate);
    
    image(chefImg, 0, 0, 280, 380); // Ukuran sama seperti scene 4
    popMatrix();
    imageMode(CORNER);
  } else {
    // Placeholder jika gambar tidak ada
    fill(255, 255, 255);
    stroke(200);
    strokeWeight(3);
    rect(chefX - 140, chefY - 190, 280, 380, 15);
    
    fill(0);
    textAlign(CENTER);
    textSize(20);
    text("CHEF BUDI", chefX, chefY - 130);
    text("Ahli Masakan", chefX, chefY - 100);
    text("Tradisional", chefX, chefY - 75);
  }
}

void drawRendangWithImage() {
  // Gambar rendang dengan rendang.png seperti di scene 4
  float rendangX = width/2 + 200;
  float rendangY = height/2 + 50;
  
  // Piring rendang (diperbesar lagi)
  fill(255, 255, 255);
  stroke(220, 220, 220);
  strokeWeight(3);
  ellipse(rendangX, rendangY, 180, 180); // Diperbesar lagi dari 120x120 ke 180x180
  
  // Gambar rendang (diperbesar lagi)
  if (imagesLoaded && rendangImg != null) {
    imageMode(CENTER);
    image(rendangImg, rendangX, rendangY, 150, 150); // Diperbesar lagi dari 100x100 ke 150x150
    imageMode(CORNER);
  } else {
    // Placeholder rendang (diperbesar lagi)
    fill(139, 69, 19);
    noStroke();
    ellipse(rendangX, rendangY, 120, 90); // Diperbesar lagi dari 80x60 ke 120x90
    
    // Detail rendang (diperbesar lagi)
    fill(160, 82, 45);
    ellipse(rendangX - 20, rendangY - 12, 35, 40); // Diperbesar lagi
    ellipse(rendangX + 20, rendangY + 12, 35, 40); // Diperbesar lagi
  }
}

void drawModernCookingEquipment() {
  // Kompor modern
  float stoveX = width/2 - 100;
  float stoveY = height - 180;
  
  // Base kompor
  fill(60, 60, 60);
  stroke(50, 50, 50);
  strokeWeight(3);
  rect(stoveX, stoveY, 80, 60, 8);
  
  // Burner modern
  fill(40, 40, 40);
  stroke(30, 30, 30);
  strokeWeight(2);
  ellipse(stoveX + 20, stoveY + 20, 25, 25);
  ellipse(stoveX + 60, stoveY + 20, 25, 25);
  ellipse(stoveX + 20, stoveY + 50, 25, 25);
  ellipse(stoveX + 60, stoveY + 50, 25, 25);
  
  // Api yang menyala
  float flameIntensity = sin(modernKitchenTimer * 5) * 0.3 + 0.7;
  fill(255, 100, 0, 150 * flameIntensity);
  noStroke();
  ellipse(stoveX + 20, stoveY + 20, 15 * flameIntensity, 15 * flameIntensity);
  ellipse(stoveX + 60, stoveY + 20, 15 * flameIntensity, 15 * flameIntensity);
  
  // Panci modern
  float panX = width/2 + 50;
  float panY = height - 190;
  
  // Panci stainless steel
  fill(220, 220, 220);
  stroke(200, 200, 200);
  strokeWeight(2);
  ellipse(panX, panY, 60, 20);
  
  // Handle panci
  fill(180, 180, 180);
  stroke(160, 160, 160);
  strokeWeight(1);
  rect(panX + 25, panY - 3, 20, 6, 3);
  
  // Uap dari panci
  steamEffect += 0.1;
  for (int i = 0; i < 5; i++) {
    float steamX = panX + random(-20, 20);
    float steamY = panY - 15 - sin(steamEffect + i) * 10;
    float steamSize = random(3, 8);
    
    fill(200, 200, 200, 100);
    noStroke();
    ellipse(steamX, steamY, steamSize, steamSize);
  }
  
  // Blender modern
  float blenderX = width/2 + 150;
  float blenderY = height - 180;
  
  // Base blender
  fill(80, 80, 80);
  stroke(70, 70, 70);
  strokeWeight(2);
  rect(blenderX - 15, blenderY, 30, 40, 5);
  
  // Container blender
  fill(200, 200, 200, 150);
  stroke(180, 180, 180);
  strokeWeight(1);
  ellipse(blenderX, blenderY - 5, 25, 30);
  
  // Button blender
  fill(255, 100, 100);
  stroke(200, 80, 80);
  strokeWeight(1);
  ellipse(blenderX, blenderY + 15, 8, 8);
}

void drawFloatingIngredients() {
  // Update floating particles
  for (int i = floatingParticles.size() - 1; i >= 0; i--) {
    FloatingParticle p = floatingParticles.get(i);
    p.update();
    if (p.isDead()) {
      floatingParticles.remove(i);
    }
  }
  
  // Add new particles occasionally
  if (random(1) < 0.1) {
    float x = random(100, width - 100);
    float y = height - 150;
    color[] colors = {color(255, 100, 100), color(100, 255, 100), color(100, 100, 255), color(255, 255, 100)};
    floatingParticles.add(new FloatingParticle(x, y, colors[int(random(colors.length))]));
  }
  
  // Display all particles
  for (FloatingParticle p : floatingParticles) {
    p.display();
  }
  
  // Floating ingredients
  ingredientFloatY = sin(modernKitchenTimer * 1.5) * 5;
  
  // Tomat floating
  float tomatoX = width/2 - 150;
  float tomatoY = height - 200 + ingredientFloatY;
  
  fill(255, 50, 50);
  stroke(200, 40, 40);
  strokeWeight(2);
  ellipse(tomatoX, tomatoY, 20, 20);
  
  // Daun tomat
  fill(50, 150, 50);
  stroke(40, 120, 40);
  strokeWeight(1);
  ellipse(tomatoX, tomatoY - 8, 8, 4);
  
  // Bawang floating
  float onionX = width/2 + 150;
  float onionY = height - 220 + ingredientFloatY;
  
  fill(255, 255, 200);
  stroke(240, 240, 180);
  strokeWeight(2);
  ellipse(onionX, onionY, 18, 18);
  
  // Detail bawang
  stroke(220, 220, 160);
  strokeWeight(1);
  noFill();
  ellipse(onionX, onionY, 12, 12);
  ellipse(onionX, onionY, 8, 8);
}

void drawKitchenAmbience() {
  // Lighting effects
  float lightIntensity = sin(modernKitchenTimer * 0.5) * 0.2 + 0.8;
  
  // Overhead lighting
  fill(255, 255, 200, 30 * lightIntensity);
  noStroke();
  ellipse(width/2, 100, 200, 100);
  
  // Ambient glow
  fill(255, 255, 255, 10 * lightIntensity);
  rect(0, 0, width, height);
  
  // Modern kitchen accessories
  // Coffee maker
  float coffeeX = width - 100;
  float coffeeY = height - 180;
  
  fill(70, 70, 70);
  stroke(60, 60, 60);
  strokeWeight(2);
  rect(coffeeX - 20, coffeeY, 40, 50, 5);
  
  // Coffee pot
  fill(200, 200, 200, 150);
  stroke(180, 180, 180);
  strokeWeight(1);
  ellipse(coffeeX, coffeeY - 10, 15, 20);
  
  // Microwave
  float microwaveX = 100;
  float microwaveY = height - 180;
  
  fill(80, 80, 80);
  stroke(70, 70, 70);
  strokeWeight(2);
  rect(microwaveX - 25, microwaveY, 50, 40, 5);
  
  // Microwave door
  fill(60, 60, 60);
  stroke(50, 50, 50);
  strokeWeight(1);
  rect(microwaveX - 20, microwaveY + 5, 40, 30, 3);
  
  // Handle microwave
  fill(200, 200, 200);
  stroke(180, 180, 180);
  strokeWeight(1);
  rect(microwaveX + 15, microwaveY + 15, 3, 10, 1);
  
  // Digital clock
  fill(0, 0, 0);
  stroke(50, 50, 50);
  strokeWeight(2);
  rect(width/2 - 30, 80, 60, 30, 5);
  
  fill(0, 255, 0);
  textAlign(CENTER);
  textSize(12);
  text("12:34", width/2, 100);
}

void setup() {
  size(1200, 800);
  
  loadAllImages();
  
  bellX = width/2;
  bellY = height/2;

  floatingParticles = new ArrayList<FloatingParticle>();
  traditionalParticles = new ArrayList<TraditionalParticle>();
  rusticParticles = new ArrayList<RusticParticle>();
  
  isRinging = true;
}

void draw() {
  background(245, 245, 220);
  
  switch(currentScene) {
    case 1:
      drawScene1();
      break;
    case 2:
      drawScene2();
      break;
    case 3:
      drawScene3();
      break;
    case 4:
      drawScene4();
      break;
    case 5:
      drawScene5();
      break;
    case 6:
      drawScene6();
      break;
    case 7:
      drawScene7();
      break;
    case 8:
      drawScene8();
      break;
    default:
      drawPlaceholderScene();
      break;
  }
  
  drawSceneIndicator();
}

void loadAllImages() {
  try {
    println("Memulai loading gambar...");
    
    // Load images that exist in data folder
    guruImg = loadImage("data/guru.png");
    if (guruImg == null) guruImg = loadImage("guru.png");
    println("guruImg: " + (guruImg != null ? "OK" : "FAILED"));
    
    chefImg = loadImage("data/chef.png");
    if (chefImg == null) chefImg = loadImage("chef.png");
    println("chefImg: " + (chefImg != null ? "OK" : "FAILED"));
    
    murid1Img = loadImage("data/murid1.png");
    if (murid1Img == null) murid1Img = loadImage("murid1.png");
    println("murid1Img: " + (murid1Img != null ? "OK" : "FAILED"));
    
    murid2Img = loadImage("data/murid2.png");
    if (murid2Img == null) murid2Img = loadImage("murid2.png");
    println("murid2Img: " + (murid2Img != null ? "OK" : "FAILED"));
    
    murid3Img = loadImage("data/murid3.png");
    if (murid3Img == null) murid3Img = loadImage("murid3.png");
    println("murid3Img: " + (murid3Img != null ? "OK" : "FAILED"));
    
    rendangImg = loadImage("data/rendang.png");
    if (rendangImg == null) rendangImg = loadImage("rendang.png");
    println("rendangImg: " + (rendangImg != null ? "OK" : "FAILED"));
    
    papedaImg = loadImage("data/papeda.png");
    if (papedaImg == null) papedaImg = loadImage("papeda.png");
    println("papedaImg: " + (papedaImg != null ? "OK" : "FAILED"));
    
    kelasImg = loadImage("data/kelasbg.jpg");
    if (kelasImg == null) kelasImg = loadImage("kelasbg.jpg");
    println("kelasImg: " + (kelasImg != null ? "OK" : "FAILED"));
    
    // Use alternative images for missing ones
    gudegImg = loadImage("data/gudeg.png");
    if (gudegImg == null) gudegImg = loadImage("gudeg.png");
    println("gudegImg: " + (gudegImg != null ? "OK" : "FAILED"));
    
    cotoImg = loadImage("data/coto.png");
    if (cotoImg == null) cotoImg = loadImage("coto.png");
    println("cotoImg: " + (cotoImg != null ? "OK" : "FAILED"));
    
    dapurImg = loadImage("data/kelasbg.jpg");
    if (dapurImg == null) dapurImg = loadImage("kelasbg.jpg");
    println("dapurImg: " + (dapurImg != null ? "OK" : "FAILED"));
    
    papanTulisImg = loadImage("data/kelasbg.jpg");
    if (papanTulisImg == null) papanTulisImg = loadImage("kelasbg.jpg");
    println("papanTulisImg: " + (papanTulisImg != null ? "OK" : "FAILED"));
    
    pisangijoImg = loadImage("data/pisangijo.png");
    if (pisangijoImg == null) pisangijoImg = loadImage("pisangijo.png");
    println("pisangijoImg: " + (pisangijoImg != null ? "OK" : "FAILED"));
    
    // Check if all critical images are loaded
    if (guruImg != null && chefImg != null && murid1Img != null && rendangImg != null && papedaImg != null && kelasImg != null && pisangijoImg != null) {
      imagesLoaded = true;
      println("SEMUA GAMBAR BERHASIL DIMUAT!");
    } else {
      imagesLoaded = false;
      println("BEBERAPA GAMBAR GAGAL DIMUAT!");
    }
    
  } catch (Exception e) {
    println("Error loading images: " + e.getMessage());
    imagesLoaded = false;
  }
}

void drawScene1() {
  drawBrickBackground();
  drawBell();

  
  if (isRinging) {
    ringTimer += 0.016;
    
    if (ringTimer > 0.8 && ringCount < maxRings) {

      ringCount++;
      ringTimer = 0;
    }
    
    if (ringCount >= maxRings) {
      isRinging = false;
    }
  }
  

}

void drawScene2() {
  // Background kelas yang diperbaiki - sama dengan scene 3
  if (imagesLoaded && kelasImg != null) {
    // Pastikan gambar kelas ter-center dan proporsional
    imageMode(CORNER);
    image(kelasImg, 0, 0, width, height);
  } else {
    drawClassroomBackground();
  }
  
  drawTeacher();
  // Murid, meja, dan kursi dihapus
  

}

void drawScene3() {
  // Background kelas yang diperbaiki
  if (imagesLoaded && kelasImg != null) {
    // Pastikan gambar kelas ter-center dan proporsional
    imageMode(CORNER);
    image(kelasImg, 0, 0, width, height);
  } else {
    drawClassroomBackground();
  }
  
  // Chef masuk dengan animasi yang lebih cepat dan goyangan kecil
  if (chefWalking) {
    chefWalkX += 4; // Lebih cepat
    if (chefWalkX > width/2 - 30) { // Berhenti lebih cepat
      chefWalking = false;
    }
  }
  drawChefEnteringSimple(chefWalkX, height - 200, chefWalking);
  

}

void drawScene4() {
  drawDetailedKitchenBackgroundWithoutStoveAndCabinets();
  drawChefIntroduction();
  drawDetailedStoveFrontView();
  drawPisangIjo();
  // Pastikan objek dapur terlihat
  drawKitchenObjectsOnTable();
}

void drawScene5() {
  // Scene 5: Dapur Modern dengan Perspektif Depan
  drawModernKitchenFrontView();
  drawChefWithImage();
  drawModernCookingEquipment();
  drawRendangWithImage();
  drawFloatingIngredients();
  drawKitchenAmbience();
}

void drawScene6() {
  // Scene 6: Dapur Tradisional dengan Tema Gudeg
  drawTraditionalKitchenBackground();
  drawChefWithImageScene6();
  drawTraditionalCookingEquipment();
  drawGudegWithImage();
  drawTraditionalKitchenAmbience();
}

void drawScene7() {
  // Scene 7: Dapur Rustic Industrial dengan Tema Papeda
  drawRusticKitchenBackground();
  drawChefWithImageScene7();
  drawRusticCookingEquipment();
  drawPapedaWithImage();
  drawRusticKitchenAmbience();
}

void drawScene8() {
  // Background kelas yang diperbaiki
  if (imagesLoaded && kelasImg != null) {
    // Pastikan gambar kelas ter-center dan proporsional
    imageMode(CORNER);
    image(kelasImg, 0, 0, width, height);
  } else {
    drawClassroomBackground();
  }
  
  // Chef masuk dengan animasi yang lebih cepat dan goyangan kecil
  if (chefWalking) {
    chefWalkX += 4; // Lebih cepat
    if (chefWalkX > width/2 - 30) { // Berhenti lebih cepat
      chefWalking = false;
    }
  }
  drawChefEnteringSimple(chefWalkX, height - 200, chefWalking);
  

}



void drawBlackboardScene3() {
  // Papan tulis dengan posisi yang diperbaiki
  float boardX = width/2 - 200;
  float boardY = 50;
  float boardW = 400;
  float boardH = 300;
  
  // Shadow
  fill(0, 0, 0, 30);
  rect(boardX + 5, boardY + 5, boardW, boardH, 15);
  
  // Frame kayu
  fill(101, 67, 33);
  stroke(80, 50, 20);
  strokeWeight(3);
  rect(boardX - 15, boardY - 15, boardW + 30, boardH + 30, 20);
  
  // Surface papan tulis
  fill(25, 60, 25);
  stroke(20, 45, 20);
  strokeWeight(2);
  rect(boardX, boardY, boardW, boardH, 12);
  
  // Tulisan yang sama
  fill(255, 255, 255, 220);
  textAlign(CENTER);
  textSize(28);
  text("Makanan Tradisional Indonesia", boardX + boardW/2, boardY + 60);
  
  stroke(255, 255, 255, 180);
  strokeWeight(2);
  line(boardX + 50, boardY + 80, boardX + boardW - 50, boardY + 80);
  noStroke();
  
  textAlign(LEFT);
  textSize(20);
  fill(255, 255, 255, 200);
  text("Hari ini kita akan belajar:", boardX + 30, boardY + 120);
  
  textSize(18);
  fill(255, 255, 255, 190);
  text("• Rendang dari Sumatera Barat", boardX + 50, boardY + 160);
  text("• Pisang Ijo dari Makassar", boardX + 50, boardY + 190);
  text("• Coto Makassar dari Sulawesi", boardX + 50, boardY + 220);
  text("• Papeda dari Papua", boardX + 50, boardY + 250);
}

void drawStudentsFromBehindExcited() {
  // Posisi murid yang diperbaiki agar tidak menutupi chef
  float[] studentX = {width/2 + 150, width/2 + 280, width/2 + 410};
  float studentY = height - 200;
  
  drawDesksScene3(studentX, studentY);
  
  for (int i = 0; i < 3; i++) {
    drawStudentFromBehindExcited(studentX[i], studentY - 50, i);
  }
}

void drawDesksScene3(float[] deskX, float deskY) {
  for (int i = 0; i < deskX.length; i++) {
    // Desk shadow
    fill(0, 0, 0, 30);
    rect(deskX[i] - 50, deskY + 7, 100, 80, 10);
    
    // Desk surface
    fill(139, 115, 85);
    stroke(120, 95, 65);
    strokeWeight(3);
    rect(deskX[i] - 48, deskY + 5, 96, 78, 10);
    
    // Wood grain
    stroke(160, 130, 95);
    strokeWeight(1);
    for (int j = 0; j < 3; j++) {
      line(deskX[i] - 43, deskY + 15 + j * 20, deskX[i] + 40, deskY + 15 + j * 20);
    }
    
    // Desk legs
    fill(120, 95, 65);
    noStroke();
    rect(deskX[i] - 40, deskY + 83, 12, 45);
    rect(deskX[i] + 25, deskY + 83, 12, 45);
    
    // Chair
    fill(101, 75, 55);
    stroke(80, 60, 40);
    strokeWeight(2);
    rect(deskX[i] - 35, deskY + 90, 70, 40, 8);
    rect(deskX[i] - 35, deskY + 45, 70, 18, 8);
    
    // Chair legs
    fill(80, 60, 40);
    noStroke();
    rect(deskX[i] - 30, deskY + 130, 8, 30);
    rect(deskX[i] + 20, deskY + 130, 8, 30);
    rect(deskX[i] - 30, deskY + 63, 8, 67);
    rect(deskX[i] + 20, deskY + 63, 8, 67);
  }
}

void drawStudentFromBehindExcited(float x, float y, int studentId) {
  pushMatrix();
  translate(x, y);
  
  // Excited movement - lebih aktif
  float excitement = sin(millis() * 0.008 + studentId * 2) * 4;
  translate(0, excitement);
  
  // Slight head turn to look at chef
  float headTurn = sin(millis() * 0.005 + studentId) * 0.15;
  rotate(headTurn);
  
  if (studentId == 0) {
    drawStudent1Excited();
  } else if (studentId == 1) {
    drawStudent2Excited();
  } else if (studentId == 2) {
    drawStudent3Excited();
  }
  
  popMatrix();
  
  // Shadow
  fill(0, 0, 0, 30);
  ellipse(x, y + 80, 80, 18);
}

void drawStudent1Excited() {
  // Student 1 excited - sedikit menoleh
  fill(255, 220, 177);
  stroke(200, 180, 150);
  strokeWeight(2);
  ellipse(0, -40, 50, 50);
  
  fill(30, 20, 10);
  noStroke();
  ellipse(0, -50, 55, 45);
  
  fill(255, 220, 177);
  rect(-8, -15, 16, 25);
  
  fill(220, 60, 60);
  stroke(180, 40, 40);
  strokeWeight(2);
  rect(-35, -10, 70, 90, 10);
  
  // Arms slightly raised (excited)
  fill(220, 60, 60);
  ellipse(-38, 5, 25, 70);
  ellipse(38, 5, 25, 70);
  
  fill(255, 220, 177);
  ellipse(-38, 40, 15, 15);
  ellipse(38, 40, 15, 15);
  
  fill(25, 25, 112);
  stroke(15, 15, 80);
  strokeWeight(2);
  rect(-35, 80, 70, 50);
}

void drawStudent2Excited() {
  // Student 2 excited
  fill(255, 220, 177);
  stroke(200, 180, 150);
  strokeWeight(2);
  ellipse(0, -40, 48, 48);
  
  fill(80, 50, 30);
  noStroke();
  ellipse(0, -50, 52, 42);
  ellipse(0, -70, 15, 35);
  
  // Pita yang bergerak excited
  fill(255, 100, 150);
  rect(-8, -55, 16, 4, 2);
  
  fill(255, 220, 177);
  rect(-7, -15, 14, 28);
  
  fill(60, 180, 60);
  stroke(40, 140, 40);
  strokeWeight(2);
  rect(-32, -8, 64, 85, 10);
  
  fill(60, 180, 60);
  ellipse(-33, 3, 22, 65);
  ellipse(33, 3, 22, 65);
  
  fill(255, 220, 177);
  ellipse(-33, 37, 12, 12);
  ellipse(33, 37, 12, 12);
  
  fill(25, 25, 112);
  stroke(15, 15, 80);
  strokeWeight(2);
  rect(-32, 77, 64, 45);
}

void drawStudent3Excited() {
  // Student 3 excited
  fill(255, 220, 177);
  stroke(200, 180, 150);
  strokeWeight(2);
  ellipse(0, -40, 55, 52);
  
  fill(60, 40, 20);
  noStroke();
  ellipse(0, -52, 60, 48);
  
  // Curly hair bouncing
  fill(70, 50, 30);
  for (int i = 0; i < 8; i++) {
    float angle = i * PI/4;
    float curlyX = cos(angle) * 25;
    float curlyY = sin(angle) * 20 - 52;
    ellipse(curlyX, curlyY, 8, 12);
  }
  
  fill(255, 220, 177);
  rect(-10, -15, 20, 25);
  
  fill(60, 120, 220);
  stroke(40, 90, 180);
  strokeWeight(2);
  rect(-38, -8, 76, 95, 12);
  
  fill(60, 120, 220);
  ellipse(-40, 7, 28, 72);
  ellipse(40, 7, 28, 72);
  
  fill(255, 220, 177);
  ellipse(-40, 43, 16, 16);
  ellipse(40, 43, 16, 16);
  
  fill(25, 25, 112);
  stroke(15, 15, 80);
  strokeWeight(2);
  rect(-38, 87, 76, 48);
}

void drawTeacherIntroducing() {
  // Guru di samping kiri dengan gesture memperkenalkan
  float teacherX = width/2 - 200;
  float teacherY = height - 220;
  
  if (imagesLoaded && guruImg != null) {
    imageMode(CENTER);
    pushMatrix();
    translate(teacherX, teacherY);
    
    // Gesture memperkenalkan chef
    float introAngle = sin(millis() * 0.01) * 0.2;
    rotate(introAngle);
    
    // Movement while introducing
    float introducingBob = sin(millis() * 0.008) * 2;
    translate(0, introducingBob);
    
    image(guruImg, 0, 0, 220, 300);
    popMatrix();
    
    fill(0, 0, 0, 40);
    ellipse(teacherX, height - 140, 120, 25);
    
  } else {
    // Placeholder teacher
    fill(100, 149, 237);
    stroke(80, 120, 200);
    strokeWeight(3);
    rect(teacherX - 50, teacherY - 80, 100, 160, 15);
    
    fill(255);
    textAlign(CENTER);
    textSize(16);
    text("GURU", teacherX, teacherY - 90);
    text("(guru.png)", teacherX, teacherY);
    text("not found", teacherX, teacherY + 20);
  }
}

void drawChefEntering(float x, float y, boolean walking) {
  if (imagesLoaded && chefImg != null) {
    imageMode(CENTER);
    pushMatrix();
    translate(x, y);
    
    if (walking) {
      // Walking animation
      float walkBounce = sin(millis() * 0.03) * 4;
      translate(0, walkBounce);
      
      // Slight forward lean while walking
      rotate(0.1);
    } else {
      // Arrived and greeting
      float greetingSway = sin(millis() * 0.01) * 3;
      translate(greetingSway, 0);
    }
    
    image(chefImg, 0, 0, 250, 350);
    popMatrix();
    
    // Chef shadow
    fill(0, 0, 0, 40);
    ellipse(x, y + 120, 200, 40);
    
  } else {
    // Placeholder chef
    fill(255, 255, 255);
    stroke(200);
    strokeWeight(3);
    rect(x - 80, y - 120, 160, 240, 15);
    
    fill(0);
    textAlign(CENTER);
    textSize(18);
    text("CHEF", x, y - 130);
    text("(chef.png)", x, y - 10);
    text("not found", x, y + 15);
    
    // Simple chef hat
    fill(255);
    stroke(200);
    strokeWeight(2);
    rect(x - 45, y - 150, 90, 30, 8);
    ellipse(x, y - 155, 75, 35);
  }
}

// Fungsi chef dengan goyangan yang lebih kecil untuk scene 3
void drawChefEnteringSimple(float x, float y, boolean walking) {
  if (imagesLoaded && chefImg != null) {
    imageMode(CENTER);
    pushMatrix();
    translate(x, y);
    
    if (walking) {
      // Walking animation dengan goyangan kecil
      float walkBounce = sin(millis() * 0.02) * 1.5; // Goyangan lebih kecil
      translate(0, walkBounce);
      
      // Slight forward lean while walking
      rotate(0.05); // Rotasi lebih kecil
    } else {
      // Arrived and greeting dengan goyangan kecil
      float greetingSway = sin(millis() * 0.008) * 1; // Goyangan lebih kecil
      translate(greetingSway, 0);
    }
    
    image(chefImg, 0, 0, 250, 350);
    popMatrix();
    
    // Chef shadow
    fill(0, 0, 0, 40);
    ellipse(x, y + 120, 200, 40);
    
  } else {
    // Placeholder chef
    fill(255, 255, 255);
    stroke(200);
    strokeWeight(3);
    rect(x - 80, y - 120, 160, 240, 15);
    
    fill(0);
    textAlign(CENTER);
    textSize(18);
    text("CHEF", x, y - 130);
    text("(chef.png)", x, y - 10);
    text("not found", x, y + 15);
    
    // Simple chef hat
    fill(255);
    stroke(200);
    strokeWeight(2);
    rect(x - 45, y - 150, 90, 30, 8);
    ellipse(x, y - 155, 75, 35);
  }
}

void drawClassroomDoor(float x, float y) {
  // Door frame yang lebih realistis
  fill(139, 69, 19);
  stroke(100, 50, 15);
  strokeWeight(4);
  rect(x, y, 140, 280, 12);
  
  // Door surface
  fill(160, 82, 45);
  stroke(120, 60, 30);
  strokeWeight(2);
  rect(x + 12, y + 12, 116, 256, 8);
  
  // Door panels
  stroke(140, 70, 35);
  strokeWeight(2);
  rect(x + 25, y + 30, 90, 100, 5);
  rect(x + 25, y + 150, 90, 100, 5);
  
  // Door handle
  fill(255, 215, 0);
  stroke(200, 180, 0);
  strokeWeight(1);
  ellipse(x + 120, y + 140, 12, 12);
  
  // Door window
  fill(135, 206, 235, 180);
  stroke(139, 69, 19);
  strokeWeight(3);
  rect(x + 35, y + 40, 70, 80, 5);
  
  // Window cross
  line(x + 70, y + 40, x + 70, y + 120);
  line(x + 35, y + 80, x + 105, y + 80);
}

void drawPlaceholderScene() {
  fill(255, 250, 240);
  rect(0, 0, width, height);
  drawTitle("Scene " + currentScene, "Sedang dalam pengembangan");
}

void drawBrickBackground() {
  fill(139, 69, 19);
  noStroke();
  rect(0, 0, width, height);
  
  stroke(101, 67, 33);
  strokeWeight(2);
  
  int brickWidth = 60;
  int brickHeight = 30;
  
  for (int row = 0; row < height/brickHeight + 1; row++) {
    for (int col = 0; col < width/brickWidth + 1; col++) {
      int offsetX = (row % 2 == 0) ? 0 : brickWidth/2;
      int x = col * brickWidth + offsetX;
      int y = row * brickHeight;
      
      if (x < width) {
        line(x, y, x, y + brickHeight);
      }
    }
    line(0, row * brickHeight, width, row * brickHeight);
  }
}

void drawBell() {
  pushMatrix();
  translate(bellX, bellY);
  
  if (isRinging) {
    bellSwing = sin(millis() * 0.02) * 0.3;
  } else {
    bellSwing *= 0.95;
  }
  
  rotate(bellSwing);
  
  stroke(139, 69, 19);
  strokeWeight(8);
  line(0, -120, 0, -70);
  
  fill(100);
  noStroke();
  ellipse(0, -70, 20, 20);
  
  fill(220, 20, 60);
  stroke(180, 15, 45);
  strokeWeight(4);
  
  beginShape();
  vertex(0, -60);
  bezierVertex(-60, -60, -80, -20, -80, 20);
  bezierVertex(-80, 60, -60, 80, 0, 80);
  bezierVertex(60, 80, 80, 60, 80, 20);
  bezierVertex(80, -20, 60, -60, 0, -60);
  endShape(CLOSE);
  
  fill(255, 100, 120);
  noStroke();
  ellipse(-25, -20, 20, 25);
  
  fill(80);
  ellipse(0, 40, 15, 30);
  
  popMatrix();
}

void drawClassroomBackground() {
  for (int i = 0; i < height; i++) {
    float inter = map(i, 0, height, 0, 1);
    color topColor = color(250, 248, 240);
    color bottomColor = color(245, 240, 230);
    color gradientColor = lerpColor(topColor, bottomColor, inter);
    stroke(gradientColor);
    line(0, i, width, i);
  }
  
  fill(160, 140, 120);
  noStroke();
  rect(0, height-120, width, 120);
  
  stroke(140, 120, 100);
  strokeWeight(1);
  for (int i = 0; i < width; i += 60) {
    for (int j = height-120; j < height; j += 40) {
      line(i, j, i + 60, j);
      line(i, j, i, j + 40);
    }
  }
  noStroke();
  
  drawWindows();
}

void drawWindows() {
  // Jendela kiri
  float window1X = 80;
  float window1Y = 60;
  float windowW = 150;
  float windowH = 180;
  drawFourPaneWindow(window1X, window1Y, windowW, windowH);

  // Jendela kanan
  float window2X = width - 230;
  float window2Y = 60;
  drawFourPaneWindow(window2X, window2Y, windowW, windowH);
}

void drawFourPaneWindow(float x, float y, float w, float h) {
  // Frame jendela
  fill(139, 115, 85);
  stroke(120, 95, 65);
  strokeWeight(5);
  rect(x, y, w, h, 10);

  // Kaca biru transparan
  fill(135, 206, 235, 180);
  stroke(180, 220, 250, 180);
  strokeWeight(2);
  rect(x + 8, y + 8, w - 16, h - 16, 6);

  // Garis pemisah 2x2 (4 kaca)
  stroke(120, 95, 65);
  strokeWeight(4);
  // Vertikal tengah
  line(x + w/2, y + 8, x + w/2, y + h - 8);
  // Horizontal tengah
  line(x + 8, y + h/2, x + w - 8, y + h/2);

  // Efek refleksi kaca
  noStroke();
  fill(255, 255, 255, 60);
  rect(x + 14, y + 14, w/3, h/5, 3);

  // Handle kuning di tengah bawah
  fill(255, 215, 0);
  stroke(200, 180, 0);
  strokeWeight(2);
  ellipse(x + w/2, y + h - 18, 10, 10);
  noStroke();
}

// Fungsi untuk menggambar objek dapur di atas meja
void drawKitchenObjectsOnTable() {
  // Rak piring di atas meja
  drawPlateRack();
  
  // Peralatan makan di atas meja
  drawKitchenUtensilsOnTable();
}

void drawPlateRack() {
  float rackX = 200; // Geser ke kiri dari 300 ke 200
  float rackY = height - 120;
  float rackW = 180;
  float rackH = 60;
  
  // Rak kayu
  fill(139, 115, 85);
  stroke(120, 95, 65);
  strokeWeight(3);
  rect(rackX, rackY, rackW, rackH, 8);
  
  // Piring-piring di rak
  for (int i = 0; i < 4; i++) {
    float plateX = rackX + 25 + i * 35; // Kurangi jarak antar piring dari 40 ke 35
    float plateY = rackY + 20;
    
    // Piring putih
    fill(255, 255, 255);
    stroke(220, 220, 220);
    strokeWeight(2);
    ellipse(plateX, plateY, 30, 30);
    
    // Detail piring
    fill(240, 240, 240);
    noStroke();
    ellipse(plateX, plateY, 25, 25);
    
    // Tepi piring
    fill(255, 255, 255);
    stroke(220, 220, 220);
    strokeWeight(1);
    ellipse(plateX, plateY, 20, 20);
  }
  
  // Piring tambahan di bawah
  for (int i = 0; i < 3; i++) {
    float plateX = rackX + 40 + i * 40; // Kurangi jarak antar piring dari 45 ke 40
    float plateY = rackY + 50;
    
    fill(255, 255, 255);
    stroke(220, 220, 220);
    strokeWeight(2);
    ellipse(plateX, plateY, 25, 25);
    
    fill(240, 240, 240);
    noStroke();
    ellipse(plateX, plateY, 20, 20);
  }
}

void drawKitchenUtensilsOnTable() {
  float utensilsX = 400; // Geser ke kiri dari 500 ke 400
  float utensilsY = height - 100;
  
  // Wadah peralatan makan
  fill(200, 200, 200);
  stroke(180, 180, 180);
  strokeWeight(2);
  rect(utensilsX, utensilsY, 70, 40, 5); // Perbesar lebar dari 60 ke 70
  
  // Sendok
  drawSpoon(utensilsX + 10, utensilsY + 10);
  
  // Garpu
  drawFork(utensilsX + 25, utensilsY + 10);
  
  // Pisau
  drawKnife(utensilsX + 40, utensilsY + 10);
}

void drawSpoon(float x, float y) {
  // Handle sendok
  fill(192, 192, 192);
  stroke(150, 150, 150);
  strokeWeight(1);
  rect(x - 2, y, 4, 15, 2);
  
  // Kepala sendok
  fill(220, 220, 220);
  noStroke();
  ellipse(x, y - 2, 8, 6);
  
  // Detail sendok
  fill(200, 200, 200);
  ellipse(x, y - 2, 6, 4);
}

void drawFork(float x, float y) {
  // Handle garpu
  fill(192, 192, 192);
  stroke(150, 150, 150);
  strokeWeight(1);
  rect(x - 2, y, 4, 15, 2);
  
  // Gigi garpu
  fill(220, 220, 220);
  noStroke();
  for (int i = 0; i < 4; i++) {
    rect(x - 3 + i * 2, y - 8, 1, 8);
  }
  
  // Detail garpu
  fill(200, 200, 200);
  for (int i = 0; i < 4; i++) {
    rect(x - 2.5 + i * 2, y - 6, 0.5, 6);
  }
}

void drawKnife(float x, float y) {
  // Handle pisau
  fill(139, 69, 19);
  stroke(101, 67, 33);
  strokeWeight(1);
  rect(x - 2, y, 4, 12, 2);
  
  // Bilah pisau
  fill(220, 220, 220);
  stroke(180, 180, 180);
  strokeWeight(1);
  rect(x - 1, y - 10, 2, 10, 1);
  
  // Ujung pisau
  fill(200, 200, 200);
  noStroke();
  triangle(x - 1, y - 10, x + 1, y - 10, x, y - 12);
}

void drawBlackboard() {
  float boardX = width/2 - 200;
  float boardY = 100;
  float boardW = 400;
  float boardH = 250;
  
  fill(0, 0, 0, 30);
  rect(boardX + 5, boardY + 5, boardW, boardH, 15);
  
  fill(101, 67, 33);
  stroke(80, 50, 20);
  strokeWeight(2);
  rect(boardX - 15, boardY - 15, boardW + 30, boardH + 30, 20);
  
  fill(25, 60, 25);
  stroke(20, 45, 20);
  strokeWeight(2);
  rect(boardX, boardY, boardW, boardH, 12);
  
  fill(255, 255, 255, 220);
  textAlign(CENTER);
  textSize(28);
  text("Makanan Tradisional Indonesia", boardX + boardW/2, boardY + 50);
  
  stroke(255, 255, 255, 180);
  strokeWeight(2);
  line(boardX + 50, boardY + 65, boardX + boardW - 50, boardY + 65);
  noStroke();
  
  textAlign(LEFT);
  textSize(20);
  fill(255, 255, 255, 200);
  text("Hari ini kita akan belajar:", boardX + 30, boardY + 100);
  
  textSize(18);
  fill(255, 255, 255, 190);
  text("• Rendang dari Sumatera Barat", boardX + 50, boardY + 140);
  text("• Pisang Ijo dari Makassar", boardX + 50, boardY + 170);
  text("• Coto Makassar dari Sulawesi", boardX + 50, boardY + 200);
  text("• Papeda dari Papua", boardX + 50, boardY + 230);
}

void drawTeacher() {
  float teacherX = width/2 - 120;
  float teacherY = height - 240;
  
  if (imagesLoaded && guruImg != null) {
    imageMode(CENTER);
    pushMatrix();
    translate(teacherX, teacherY);
    
    float gestureAngle = sin(millis() * 0.008) * 0.1;
    rotate(gestureAngle);
    
    float teachingBob = sin(millis() * 0.005) * 3;
    translate(0, teachingBob);
    
    image(guruImg, 0, 0, 240, 320);
    popMatrix();
    
    fill(0, 0, 0, 40);
    ellipse(teacherX, height - 140, 140, 30);
    
  } else {
    fill(100, 149, 237);
    stroke(80, 120, 200);
    strokeWeight(3);
    rect(teacherX - 60, teacherY - 90, 120, 180, 15);
    
    fill(255);
    textAlign(CENTER);
    textSize(18);
    text("GURU", teacherX, teacherY - 100);
    text("(guru.png)", teacherX, teacherY);
    text("not found", teacherX, teacherY + 25);
  }
}

void drawStudentsFromBehind() {
  float[] studentX = {width/2 + 80, width/2 + 250, width/2 + 420};
  float studentY = height - 220;
  
  drawDesks(studentX, studentY);
  
  for (int i = 0; i < 3; i++) {
    drawStudentFromBehind(studentX[i], studentY - 50, i);
  }
}

void drawDesks(float[] deskX, float deskY) {
  for (int i = 0; i < deskX.length; i++) {
    fill(0, 0, 0, 30);
    rect(deskX[i] - 57, deskY + 7, 114, 87, 10);
    
    fill(139, 115, 85);
    stroke(120, 95, 65);
    strokeWeight(3);
    rect(deskX[i] - 55, deskY + 5, 110, 85, 10);
    
    stroke(160, 130, 95);
    strokeWeight(1);
    for (int j = 0; j < 4; j++) {
      line(deskX[i] - 50, deskY + 15 + j * 18, deskX[i] + 45, deskY + 15 + j * 18);
    }
    
    fill(120, 95, 65);
    noStroke();
    rect(deskX[i] - 45, deskY + 90, 15, 50);
    rect(deskX[i] + 30, deskY + 90, 15, 50);
    
    fill(101, 75, 55);
    stroke(80, 60, 40);
    strokeWeight(2);
    rect(deskX[i] - 40, deskY + 100, 80, 45, 8);
    rect(deskX[i] - 40, deskY + 50, 80, 20, 8);
    
    fill(80, 60, 40);
    noStroke();
    rect(deskX[i] - 35, deskY + 145, 10, 35);
    rect(deskX[i] + 25, deskY + 145, 10, 35);
    rect(deskX[i] - 35, deskY + 70, 10, 75);
    rect(deskX[i] + 25, deskY + 70, 10, 75);
  }
}

void drawStudentFromBehind(float x, float y, int studentId) {
  pushMatrix();
  translate(x, y);
  
  float attentionBob = sin(millis() * 0.003 + studentId * 2) * 2;
  translate(0, attentionBob);
  
  float headTurn = sin(millis() * 0.002 + studentId) * 0.05;
  rotate(headTurn);
  
  if (studentId == 0) {
    drawStudent1();
  } else if (studentId == 1) {
    drawStudent2();
  } else if (studentId == 2) {
    drawStudent3();
  }
  
  popMatrix();
  
  fill(0, 0, 0, 30);
  ellipse(x, y + 80, 90, 20);
}

void drawStudent1() {
  fill(255, 220, 177);
  stroke(200, 180, 150);
  strokeWeight(2);
  ellipse(0, -40, 50, 50);
  
  fill(30, 20, 10);
  noStroke();
  ellipse(0, -50, 55, 45);
  
  fill(255, 220, 177);
  rect(-8, -15, 16, 25);
  
  fill(220, 60, 60);
  stroke(180, 40, 40);
  strokeWeight(2);
  rect(-35, -10, 70, 90, 10);
  
  fill(220, 60, 60);
  ellipse(-40, 10, 25, 70);
  ellipse(40, 10, 25, 70);
  
  fill(255, 220, 177);
  ellipse(-40, 45, 15, 15);
  ellipse(40, 45, 15, 15);
  
  fill(25, 25, 112);
  stroke(15, 15, 80);
  strokeWeight(2);
  rect(-35, 80, 70, 50);
}

void drawStudent2() {
  fill(255, 220, 177);
  stroke(200, 180, 150);
  strokeWeight(2);
  ellipse(0, -40, 48, 48);
  
  fill(80, 50, 30);
  noStroke();
  ellipse(0, -50, 52, 42);
  ellipse(0, -70, 15, 35);
  
  fill(255, 100, 150);
  rect(-8, -55, 16, 4, 2);
  
  fill(255, 220, 177);
  rect(-7, -15, 14, 28);
  
  fill(60, 180, 60);
  stroke(40, 140, 40);
  strokeWeight(2);
  rect(-32, -8, 64, 85, 10);
  
  fill(60, 180, 60);
  ellipse(-35, 8, 22, 65);
  ellipse(35, 8, 22, 65);
  
  fill(255, 220, 177);
  ellipse(-35, 42, 12, 12);
  ellipse(35, 42, 12, 12);
  
  fill(25, 25, 112);
  stroke(15, 15, 80);
  strokeWeight(2);
  rect(-32, 77, 64, 45);
}

void drawStudent3() {
  fill(255, 220, 177);
  stroke(200, 180, 150);
  strokeWeight(2);
  ellipse(0, -40, 55, 52);
  
  fill(60, 40, 20);
  noStroke();
  ellipse(0, -52, 60, 48);
  
  fill(70, 50, 30);
  for (int i = 0; i < 8; i++) {
    float angle = i * PI/4;
    float curlyX = cos(angle) * 25;
    float curlyY = sin(angle) * 20 - 52;
    ellipse(curlyX, curlyY, 8, 12);
  }
  
  fill(255, 220, 177);
  rect(-10, -15, 20, 25);
  
  fill(60, 120, 220);
  stroke(40, 90, 180);
  strokeWeight(2);
  rect(-38, -8, 76, 95, 12);
  
  fill(60, 120, 220);
  ellipse(-42, 12, 28, 72);
  ellipse(42, 12, 28, 72);
  
  fill(255, 220, 177);
  ellipse(-42, 48, 16, 16);
  ellipse(42, 48, 16, 16);
  
  fill(25, 25, 112);
  stroke(15, 15, 80);
  strokeWeight(2);
  rect(-38, 87, 76, 48);
}

void drawChef(float x, float y, boolean walking) {
  if (imagesLoaded && chefImg != null) {
    imageMode(CENTER);
    pushMatrix();
    translate(x, y);
    
    if (walking) {
      float walkBounce = sin(millis() * 0.02) * 3;
      translate(0, walkBounce);
      rotate(sin(millis() * 0.02) * 0.05);
    } else {
      float gentleSway = sin(millis() * 0.008) * 2;
      translate(gentleSway, 0);
    }
    
    image(chefImg, 0, 0, 150, 220);
    popMatrix();
  } else {
    fill(255, 255, 255);
    stroke(200);
    strokeWeight(3);
    rect(x - 50, y - 80, 100, 160, 10);
    
    fill(0);
    textAlign(CENTER);
    textSize(14);
    text("CHEF", x, y - 90);
    text("(chef.png)", x, y - 5);
    text("not found", x, y + 15);
  }
}



void updateClassroomAnimations() {
  teacherArmAngle += 0.03;
  
  for (int i = 0; i < 3; i++) {
    blinkTimer[i]++;
    
    if (blinkTimer[i] > random(100, 200)) {
      studentBlink[i] = 8;
      blinkTimer[i] = 0;
    }
    
    if (studentBlink[i] > 0) {
      studentBlink[i]--;
    }
  }
}

void drawTitle(String mainText, String subText) {
  fill(0, 0, 0, 120);
  noStroke();
  rect(0, height - 120, width, 120);
  
  for (int i = 0; i < 60; i++) {
    float alpha = map(i, 0, 60, 120, 0);
    stroke(0, 0, 0, alpha);
    line(0, height - 120 + i, width, height - 120 + i);
  }
  
  fill(255, 200, 100);
  textAlign(CENTER);
  textSize(36);
  text(mainText, width/2, height - 70);
  
  fill(220, 220, 220);
  textSize(20);
  text(subText, width/2, height - 35);
  
  stroke(255, 200, 100, 180);
  strokeWeight(3);
  line(width/2 - 200, height - 55, width/2 + 200, height - 55);
  noStroke();
}

void drawSceneIndicator() {
  fill(0, 0, 0, 150);
  rect(20, 20, 250, 60);
  
  fill(255);
  textAlign(LEFT);
  textSize(16);
  text("Scene " + currentScene + " / " + totalScenes, 35, 45);
  text("ENTER: Next | SPACE: Reset", 35, 65);
}

// Scene 4 Functions
void drawKitchenBackground() {
  // Gradient background untuk dapur
  for (int i = 0; i < height; i++) {
    float inter = map(i, 0, height, 0, 1);
    color topColor = color(255, 250, 240);
    color bottomColor = color(245, 235, 220);
    color gradientColor = lerpColor(topColor, bottomColor, inter);
    stroke(gradientColor);
    line(0, i, width, i);
  }
  
  // Lantai dapur
  fill(160, 140, 120);
  noStroke();
  rect(0, height-150, width, 150);
  
  // Pattern lantai
  stroke(140, 120, 100);
  strokeWeight(1);
  for (int i = 0; i < width; i += 40) {
    for (int j = height-150; j < height; j += 40) {
      line(i, j, i + 40, j);
      line(i, j, i, j + 40);
    }
  }
  noStroke();
  
  // Dinding dapur
  fill(220, 220, 220);
  rect(0, 0, width, height-150);
  
  // Kabinet dapur
  fill(139, 115, 85);
  stroke(120, 95, 65);
  strokeWeight(3);
  rect(50, 100, 200, 120, 8);
  rect(width-250, 100, 200, 120, 8);
  
  // Kompor
  fill(80, 80, 80);
  rect(width/2 - 100, height-200, 200, 80, 10);
  
  // Burner
  fill(60, 60, 60);
  ellipse(width/2 - 50, height-160, 40, 40);
  ellipse(width/2 + 50, height-160, 40, 40);
}

// Background dapur yang lebih detail dengan perspektif dari depan
void drawDetailedKitchenBackground() {
  // Gradient background untuk dapur (dari depan)
  for (int i = 0; i < height; i++) {
    float inter = map(i, 0, height, 0, 1);
    color topColor = color(255, 250, 240);
    color bottomColor = color(245, 235, 220);
    color gradientColor = lerpColor(topColor, bottomColor, inter);
    stroke(gradientColor);
    line(0, i, width, i);
  }
  
  // Lantai dapur dengan perspektif dari depan
  fill(160, 140, 120);
  noStroke();
  rect(0, height-100, width, 100);
  
  // Pattern lantai dengan perspektif
  stroke(140, 120, 100);
  strokeWeight(1);
  for (int i = 0; i < width; i += 40) {
    for (int j = height-100; j < height; j += 40) {
      line(i, j, i + 40, j);
      line(i, j, i, j + 40);
    }
  }
  noStroke();
  
  // Dinding dapur dengan wallpaper pattern (dari depan)
  fill(220, 220, 220);
  rect(0, 0, width, height-100);
  
  // Wallpaper pattern
  stroke(200, 200, 200);
  strokeWeight(1);
  for (int i = 0; i < width; i += 80) {
    for (int j = 0; j < height-100; j += 80) {
      rect(i, j, 80, 80);
    }
  }
  noStroke();
  
  // Kabinet dapur dengan perspektif dari depan
  drawDetailedCabinetsFrontView();
  
  // Ornamen dapur tambahan
  drawKitchenDecorationsFrontView();
  
  // Kompor dengan perspektif dari depan (digambar terakhir agar di depan)
  drawDetailedStoveFrontView();
}

// Background dapur tanpa kompor (untuk urutan rendering yang benar)
void drawDetailedKitchenBackgroundWithoutStove() {
  // Gradient background untuk dapur (dari depan)
  for (int i = 0; i < height; i++) {
    float inter = map(i, 0, height, 0, 1);
    color topColor = color(255, 250, 240);
    color bottomColor = color(245, 235, 220);
    color gradientColor = lerpColor(topColor, bottomColor, inter);
    stroke(gradientColor);
    line(0, i, width, i);
  }
  
  // Lantai dapur dengan perspektif dari depan
  fill(160, 140, 120);
  noStroke();
  rect(0, height-100, width, 100);
  
  // Pattern lantai dengan perspektif
  stroke(140, 120, 100);
  strokeWeight(1);
  for (int i = 0; i < width; i += 40) {
    for (int j = height-100; j < height; j += 40) {
      line(i, j, i + 40, j);
      line(i, j, i, j + 40);
    }
  }
  noStroke();
  
  // Dinding dapur dengan wallpaper pattern (dari depan)
  fill(220, 220, 220);
  rect(0, 0, width, height-100);
  
  // Wallpaper pattern
  stroke(200, 200, 200);
  strokeWeight(1);
  for (int i = 0; i < width; i += 80) {
    for (int j = 0; j < height-100; j += 80) {
      rect(i, j, 80, 80);
    }
  }
  noStroke();
  
  // Kabinet dapur dengan perspektif dari depan
  drawDetailedCabinetsFrontView();
  
  // Ornamen dapur tambahan
  drawKitchenDecorationsFrontView();
}

// Background dapur tanpa kompor dan kabinet (untuk urutan rendering yang benar)
void drawDetailedKitchenBackgroundWithoutStoveAndCabinets() {
  // Gradient background untuk dapur (dari depan)
  for (int i = 0; i < height; i++) {
    float inter = map(i, 0, height, 0, 1);
    color topColor = color(255, 250, 240);
    color bottomColor = color(245, 235, 220);
    color gradientColor = lerpColor(topColor, bottomColor, inter);
    stroke(gradientColor);
    line(0, i, width, i);
  }
  // Lantai dapur dengan perspektif dari depan
  fill(160, 140, 120);
  noStroke();
  rect(0, height-100, width, 100);
  // Pattern lantai dengan perspektif
  stroke(140, 120, 100);
  strokeWeight(1);
  for (int i = 0; i < width; i += 40) {
    for (int j = height-100; j < height; j += 40) {
      line(i, j, i + 40, j);
      line(i, j, i, j + 40);
    }
  }
  noStroke();
  // Dinding dapur dengan wallpaper pattern (dari depan)
  fill(220, 220, 220);
  rect(0, 0, width, height-100);
  // Wallpaper pattern
  stroke(200, 200, 200);
  strokeWeight(1);
  for (int i = 0; i < width; i += 80) {
    for (int j = 0; j < height-100; j += 80) {
      rect(i, j, 80, 80);
    }
  }
  noStroke();
  // TAMBAHKAN JENDELA KACA
  drawWindows();
  // TAMBAHKAN OBJEK DAPUR DI ATAS MEJA
  drawKitchenObjectsOnTable();
  // Ornamen dapur tambahan
  drawKitchenDecorationsFrontView();
}

// Kabinet dengan perspektif dari depan (dinaikkan posisinya)
void drawDetailedCabinetsFrontViewRaised() {
  // Kabinet atas kiri (dari depan) - dinaikkan
  float cabinetX1 = 80;
  float cabinetY1 = 60; // Dinaikkan dari 80
  float cabinetW = 180;
  float cabinetH = 100;
  
  // Cabinet body
  fill(139, 115, 85);
  stroke(120, 95, 65);
  strokeWeight(2);
  rect(cabinetX1, cabinetY1, cabinetW, cabinetH, 6);
  
  // Cabinet doors
  fill(160, 140, 120);
  stroke(140, 120, 100);
  strokeWeight(1);
  rect(cabinetX1 + 8, cabinetY1 + 8, cabinetW/2 - 12, cabinetH - 16, 4);
  rect(cabinetX1 + cabinetW/2 + 4, cabinetY1 + 8, cabinetW/2 - 12, cabinetH - 16, 4);
  
  // Cabinet handles
  fill(255, 215, 0);
  stroke(200, 180, 0);
  strokeWeight(1);
  ellipse(cabinetX1 + 35, cabinetY1 + cabinetH/2, 6, 6);
  ellipse(cabinetX1 + cabinetW - 35, cabinetY1 + cabinetH/2, 6, 6);
  
  // Kabinet atas kanan (dari depan) - dinaikkan
  float cabinetX2 = width - 260;
  float cabinetY2 = 60; // Dinaikkan dari 80
  
  // Cabinet body
  fill(139, 115, 85);
  stroke(120, 95, 65);
  strokeWeight(2);
  rect(cabinetX2, cabinetY2, cabinetW, cabinetH, 6);
  
  // Cabinet doors
  fill(160, 140, 120);
  stroke(140, 120, 100);
  strokeWeight(1);
  rect(cabinetX2 + 8, cabinetY2 + 8, cabinetW/2 - 12, cabinetH - 16, 4);
  rect(cabinetX2 + cabinetW/2 + 4, cabinetY2 + 8, cabinetW/2 - 12, cabinetH - 16, 4);
  
  // Cabinet handles
  fill(255, 215, 0);
  stroke(200, 180, 0);
  strokeWeight(1);
  ellipse(cabinetX2 + 35, cabinetY2 + cabinetH/2, 6, 6);
  ellipse(cabinetX2 + cabinetW - 35, cabinetY2 + cabinetH/2, 6, 6);
  
  // Kabinet bawah (dari depan) - dinaikkan
  float cabinetX3 = 80;
  float cabinetY3 = height - 140; // Dinaikkan dari height - 120
  float cabinetW2 = 250;
  float cabinetH2 = 40;
  
  // Cabinet body
  fill(139, 115, 85);
  stroke(120, 95, 65);
  strokeWeight(2);
  rect(cabinetX3, cabinetY3, cabinetW2, cabinetH2, 6);
  
  // Cabinet doors
  fill(160, 140, 120);
  stroke(140, 120, 100);
  strokeWeight(1);
  rect(cabinetX3 + 8, cabinetY3 + 8, 70, cabinetH2 - 16, 4);
  rect(cabinetX3 + 90, cabinetY3 + 8, 70, cabinetH2 - 16, 4);
  rect(cabinetX3 + 172, cabinetY3 + 8, 70, cabinetH2 - 16, 4);
  
  // Cabinet handles
  fill(255, 215, 0);
  stroke(200, 180, 0);
  strokeWeight(1);
  ellipse(cabinetX3 + 45, cabinetY3 + cabinetH2/2, 5, 5);
  ellipse(cabinetX3 + 125, cabinetY3 + cabinetH2/2, 5, 5);
  ellipse(cabinetX3 + 205, cabinetY3 + cabinetH2/2, 5, 5);
}

void drawDetailedCabinets() {
  // Kabinet atas kiri
  float cabinetX1 = 50;
  float cabinetY1 = 100;
  float cabinetW = 200;
  float cabinetH = 120;
  
  // Cabinet body
  fill(139, 115, 85);
  stroke(120, 95, 65);
  strokeWeight(3);
  rect(cabinetX1, cabinetY1, cabinetW, cabinetH, 8);
  
  // Cabinet doors
  fill(160, 140, 120);
  stroke(140, 120, 100);
  strokeWeight(2);
  rect(cabinetX1 + 10, cabinetY1 + 10, cabinetW/2 - 15, cabinetH - 20, 5);
  rect(cabinetX1 + cabinetW/2 + 5, cabinetY1 + 10, cabinetW/2 - 15, cabinetH - 20, 5);
  
  // Cabinet handles
  fill(255, 215, 0);
  stroke(200, 180, 0);
  strokeWeight(2);
  ellipse(cabinetX1 + 40, cabinetY1 + cabinetH/2, 8, 8);
  ellipse(cabinetX1 + cabinetW - 40, cabinetY1 + cabinetH/2, 8, 8);
  
  // Kabinet atas kanan
  float cabinetX2 = width - 250;
  float cabinetY2 = 100;
  
  // Cabinet body
  fill(139, 115, 85);
  stroke(120, 95, 65);
  strokeWeight(3);
  rect(cabinetX2, cabinetY2, cabinetW, cabinetH, 8);
  
  // Cabinet doors
  fill(160, 140, 120);
  stroke(140, 120, 100);
  strokeWeight(2);
  rect(cabinetX2 + 10, cabinetY2 + 10, cabinetW/2 - 15, cabinetH - 20, 5);
  rect(cabinetX2 + cabinetW/2 + 5, cabinetY2 + 10, cabinetW/2 - 15, cabinetH - 20, 5);
  
  // Cabinet handles
  fill(255, 215, 0);
  stroke(200, 180, 0);
  strokeWeight(2);
  ellipse(cabinetX2 + 40, cabinetY2 + cabinetH/2, 8, 8);
  ellipse(cabinetX2 + cabinetW - 40, cabinetY2 + cabinetH/2, 8, 8);
  
  // Kabinet bawah
  float cabinetX3 = 50;
  float cabinetY3 = height - 200;
  float cabinetW2 = 300;
  float cabinetH2 = 50;
  
  // Cabinet body
  fill(139, 115, 85);
  stroke(120, 95, 65);
  strokeWeight(3);
  rect(cabinetX3, cabinetY3, cabinetW2, cabinetH2, 8);
  
  // Cabinet doors
  fill(160, 140, 120);
  stroke(140, 120, 100);
  strokeWeight(2);
  rect(cabinetX3 + 10, cabinetY3 + 10, 80, cabinetH2 - 20, 5);
  rect(cabinetX3 + 110, cabinetY3 + 10, 80, cabinetH2 - 20, 5);
  rect(cabinetX3 + 210, cabinetY3 + 10, 80, cabinetH2 - 20, 5);
  
  // Cabinet handles
  fill(255, 215, 0);
  stroke(200, 180, 0);
  strokeWeight(2);
  ellipse(cabinetX3 + 50, cabinetY3 + cabinetH2/2, 6, 6);
  ellipse(cabinetX3 + 150, cabinetY3 + cabinetH2/2, 6, 6);
  ellipse(cabinetX3 + 250, cabinetY3 + cabinetH2/2, 6, 6);
}

// Kabinet dengan perspektif dari depan
void drawDetailedCabinetsFrontView() {
  // Kabinet atas kiri (dari depan)
  float cabinetX1 = 80;
  float cabinetY1 = 80;
  float cabinetW = 180;
  float cabinetH = 100;
  
  // Cabinet body
  fill(139, 115, 85);
  stroke(120, 95, 65);
  strokeWeight(2);
  rect(cabinetX1, cabinetY1, cabinetW, cabinetH, 6);
  
  // Cabinet doors
  fill(160, 140, 120);
  stroke(140, 120, 100);
  strokeWeight(1);
  rect(cabinetX1 + 8, cabinetY1 + 8, cabinetW/2 - 12, cabinetH - 16, 4);
  rect(cabinetX1 + cabinetW/2 + 4, cabinetY1 + 8, cabinetW/2 - 12, cabinetH - 16, 4);
  
  // Cabinet handles
  fill(255, 215, 0);
  stroke(200, 180, 0);
  strokeWeight(1);
  ellipse(cabinetX1 + 35, cabinetY1 + cabinetH/2, 6, 6);
  ellipse(cabinetX1 + cabinetW - 35, cabinetY1 + cabinetH/2, 6, 6);
  
  // Kabinet atas kanan (dari depan)
  float cabinetX2 = width - 260;
  float cabinetY2 = 80;
  
  // Cabinet body
  fill(139, 115, 85);
  stroke(120, 95, 65);
  strokeWeight(2);
  rect(cabinetX2, cabinetY2, cabinetW, cabinetH, 6);
  
  // Cabinet doors
  fill(160, 140, 120);
  stroke(140, 120, 100);
  strokeWeight(1);
  rect(cabinetX2 + 8, cabinetY2 + 8, cabinetW/2 - 12, cabinetH - 16, 4);
  rect(cabinetX2 + cabinetW/2 + 4, cabinetY2 + 8, cabinetW/2 - 12, cabinetH - 16, 4);
  
  // Cabinet handles
  fill(255, 215, 0);
  stroke(200, 180, 0);
  strokeWeight(1);
  ellipse(cabinetX2 + 35, cabinetY2 + cabinetH/2, 6, 6);
  ellipse(cabinetX2 + cabinetW - 35, cabinetY2 + cabinetH/2, 6, 6);
  
  // Kabinet bawah (dari depan)
  float cabinetX3 = 80;
  float cabinetY3 = height - 120;
  float cabinetW2 = 250;
  float cabinetH2 = 40;
  
  // Cabinet body
  fill(139, 115, 85);
  stroke(120, 95, 65);
  strokeWeight(2);
  rect(cabinetX3, cabinetY3, cabinetW2, cabinetH2, 6);
  
  // Cabinet doors
  fill(160, 140, 120);
  stroke(140, 120, 100);
  strokeWeight(1);
  rect(cabinetX3 + 8, cabinetY3 + 8, 70, cabinetH2 - 16, 4);
  rect(cabinetX3 + 90, cabinetY3 + 8, 70, cabinetH2 - 16, 4);
  rect(cabinetX3 + 172, cabinetY3 + 8, 70, cabinetH2 - 16, 4);
  
  // Cabinet handles
  fill(255, 215, 0);
  stroke(200, 180, 0);
  strokeWeight(1);
  ellipse(cabinetX3 + 45, cabinetY3 + cabinetH2/2, 5, 5);
  ellipse(cabinetX3 + 125, cabinetY3 + cabinetH2/2, 5, 5);
  ellipse(cabinetX3 + 205, cabinetY3 + cabinetH2/2, 5, 5);
}

void drawDetailedStove() {
  float stoveX = width/2 - 100;
  float stoveY = height - 200;
  float stoveW = 200;
  float stoveH = 80;
  
  // Stove body
  fill(80, 80, 80);
  stroke(60, 60, 60);
  strokeWeight(3);
  rect(stoveX, stoveY, stoveW, stoveH, 10);
  
  // Stove top
  fill(70, 70, 70);
  rect(stoveX + 10, stoveY + 10, stoveW - 20, 20, 5);
  
  // Burners
  fill(60, 60, 60);
  stroke(40, 40, 40);
  strokeWeight(2);
  ellipse(stoveX + 50, stoveY + 20, 35, 35);
  ellipse(stoveX + 150, stoveY + 20, 35, 35);
  
  // Burner rings
  fill(50, 50, 50);
  ellipse(stoveX + 50, stoveY + 20, 25, 25);
  ellipse(stoveX + 150, stoveY + 20, 25, 25);
  
  // Burner centers
  fill(40, 40, 40);
  ellipse(stoveX + 50, stoveY + 20, 15, 15);
  ellipse(stoveX + 150, stoveY + 20, 15, 15);
  
  // Control knobs
  fill(100, 100, 100);
  stroke(80, 80, 80);
  strokeWeight(2);
  rect(stoveX + 20, stoveY + 50, 15, 20, 5);
  rect(stoveX + 165, stoveY + 50, 15, 20, 5);
  
  // Knob indicators
  fill(255, 0, 0);
  noStroke();
  ellipse(stoveX + 27.5, stoveY + 60, 5, 5);
  ellipse(stoveX + 172.5, stoveY + 60, 5, 5);
}

// Kompor dengan perspektif dari depan
void drawDetailedStoveFrontView() {
  float stoveX = width/2 - 120;
  float stoveY = height - 140;
  float stoveW = 240;
  float stoveH = 60;
  
  // Stove body dengan efek lebih menonjol
  fill(70, 70, 70);
  stroke(50, 50, 50);
  strokeWeight(4);
  rect(stoveX, stoveY, stoveW, stoveH, 8);
  
  // Stove top
  fill(60, 60, 60);
  rect(stoveX + 8, stoveY + 8, stoveW - 16, 15, 4);
  
  // Burners dengan efek lebih menonjol
  fill(50, 50, 50);
  stroke(30, 30, 30);
  strokeWeight(3);
  ellipse(stoveX + 60, stoveY + 15, 30, 30);
  ellipse(stoveX + 180, stoveY + 15, 30, 30);
  
  // Burner rings
  fill(40, 40, 40);
  ellipse(stoveX + 60, stoveY + 15, 20, 20);
  ellipse(stoveX + 180, stoveY + 15, 20, 20);
  
  // Burner centers
  fill(30, 30, 30);
  ellipse(stoveX + 60, stoveY + 15, 12, 12);
  ellipse(stoveX + 180, stoveY + 15, 12, 12);
  
  // Control knobs dengan efek lebih menonjol
  fill(90, 90, 90);
  stroke(70, 70, 70);
  strokeWeight(3);
  rect(stoveX + 25, stoveY + 35, 12, 15, 4);
  rect(stoveX + 203, stoveY + 35, 12, 15, 4);
  
  // Knob indicators
  fill(255, 0, 0);
  noStroke();
  ellipse(stoveX + 31, stoveY + 42, 4, 4);
  ellipse(stoveX + 209, stoveY + 42, 4, 4);
}

void drawKitchenDecorations() {
  // Wall clock
  float clockX = width/2;
  float clockY = 80;
  
  // Clock body
  fill(255, 255, 255);
  stroke(200, 200, 200);
  strokeWeight(3);
  ellipse(clockX, clockY, 60, 60);
  
  // Clock numbers
  fill(0);
  textAlign(CENTER);
  textSize(12);
  text("12", clockX, clockY - 20);
  text("3", clockX + 20, clockY);
  text("6", clockX, clockY + 20);
  text("9", clockX - 20, clockY);
  
  // Clock hands
  stroke(0);
  strokeWeight(2);
  line(clockX, clockY, clockX, clockY - 15); // Hour hand
  line(clockX, clockY, clockX + 12, clockY); // Minute hand
  
  // Kitchen utensils on wall
  drawKitchenUtensils();
  
  // Plants
  drawKitchenPlants();
}

// Dekorasi dapur dengan perspektif dari depan
void drawKitchenDecorationsFrontView() {
  // Wall clock (dari depan)
  float clockX = width/2;
  float clockY = 60;
  
  // Clock body
  fill(255, 255, 255);
  stroke(200, 200, 200);
  strokeWeight(2);
  ellipse(clockX, clockY, 50, 50);
  
  // Clock numbers
  fill(0);
  textAlign(CENTER);
  textSize(10);
  text("12", clockX, clockY - 15);
  text("3", clockX + 15, clockY);
  text("6", clockX, clockY + 15);
  text("9", clockX - 15, clockY);
  
  // Clock hands
  stroke(0);
  strokeWeight(1);
  line(clockX, clockY, clockX, clockY - 12); // Hour hand
  line(clockX, clockY, clockX + 10, clockY); // Minute hand
  
  // Kitchen utensils on wall (dari depan)
  drawKitchenUtensilsFrontView();
  
  // Plants (dari depan)
  drawKitchenPlantsFrontView();
}

void drawKitchenUtensils() {
  // Pan on wall
  float panX = 100;
  float panY = 150;
  
  // Pan body
  fill(180, 180, 180);
  stroke(160, 160, 160);
  strokeWeight(2);
  ellipse(panX, panY, 40, 40);
  
  // Pan handle
  fill(120, 120, 120);
  rect(panX + 20, panY - 5, 25, 10, 5);
  
  // Spatula
  float spatulaX = 200;
  float spatulaY = 180;
  
  // Spatula handle
  fill(139, 69, 19);
  stroke(120, 60, 20);
  strokeWeight(2);
  rect(spatulaX - 3, spatulaY - 20, 6, 40, 3);
  
  // Spatula head
  fill(255, 255, 255);
  stroke(200, 200, 200);
  strokeWeight(2);
  ellipse(spatulaX, spatulaY, 20, 15);
}

// Peralatan dapur dengan perspektif dari depan
void drawKitchenUtensilsFrontView() {
  // Pan on wall (dari depan)
  float panX = 120;
  float panY = 120;
  
  // Pan body
  fill(180, 180, 180);
  stroke(160, 160, 160);
  strokeWeight(1);
  ellipse(panX, panY, 35, 35);
  
  // Pan handle
  fill(120, 120, 120);
  rect(panX + 17, panY - 4, 20, 8, 4);
  
  // Spatula (dari depan)
  float spatulaX = 220;
  float spatulaY = 140;
  
  // Spatula handle
  fill(139, 69, 19);
  stroke(120, 60, 20);
  strokeWeight(1);
  rect(spatulaX - 2, spatulaY - 15, 4, 30, 2);
  
  // Spatula head
  fill(255, 255, 255);
  stroke(200, 200, 200);
  strokeWeight(1);
  ellipse(spatulaX, spatulaY, 15, 12);
}

void drawKitchenPlants() {
  // Plant pot
  float potX = width - 150;
  float potY = height - 180;
  
  // Pot body
  fill(160, 82, 45);
  stroke(140, 70, 35);
  strokeWeight(2);
  ellipse(potX, potY, 50, 50);
  
  // Plant leaves
  fill(34, 139, 34);
  noStroke();
  ellipse(potX - 10, potY - 15, 15, 20);
  ellipse(potX + 10, potY - 20, 12, 18);
  ellipse(potX, potY - 25, 18, 15);
}

// Tanaman dengan perspektif dari depan
void drawKitchenPlantsFrontView() {
  // Plant pot (dari depan)
  float potX = width - 170;
  float potY = height - 100;
  
  // Pot body
  fill(160, 82, 45);
  stroke(140, 70, 35);
  strokeWeight(1);
  ellipse(potX, potY, 40, 40);
  
  // Plant leaves
  fill(34, 139, 34);
  noStroke();
  ellipse(potX - 8, potY - 12, 12, 16);
  ellipse(potX + 8, potY - 16, 10, 14);
  ellipse(potX, potY - 20, 14, 12);
}

void drawChefIntroduction() {
  // Chef diposisikan di tengah-tengah layar
  float chefX = width/2;
  float chefY = height/2; // Posisi tengah vertikal
  
  if (imagesLoaded && chefImg != null) {
    imageMode(CENTER);
    pushMatrix();
    translate(chefX, chefY);
    
    // Gesture memperkenalkan diri - goyangan sedikit saja
    float introGesture = sin(millis() * 0.01) * 0.05; // Dikurangi dari 0.15 ke 0.05
    rotate(introGesture);
    
    // Slight movement - goyangan sedikit saja
    float introBob = sin(millis() * 0.008) * 1; // Dikurangi dari 3 ke 1
    translate(0, introBob);
    
    image(chefImg, 0, 0, 280, 380); // Diperbesar dari 200x270
    popMatrix();
    
  } else {
    // Placeholder chef
    fill(255, 255, 255);
    stroke(200);
    strokeWeight(3);
    rect(chefX - 80, chefY - 120, 160, 240, 15);
    
    fill(0);
    textAlign(CENTER);
    textSize(20);
    text("CHEF BUDI", chefX, chefY - 130);
    text("Ahli Masakan", chefX, chefY - 100);
    text("Tradisional", chefX, chefY - 75);
  }
}

void drawSpeechBubble(float x, float y, String text) {
  // Bubble background
  fill(255, 255, 255, 240);
  stroke(200, 200, 200);
  strokeWeight(2);
  rect(x, y, 300, 80, 15);
  
  // Tail
  fill(255, 255, 255, 240);
  triangle(x - 20, y + 40, x, y + 30, x, y + 50);
  
  // Text
  fill(0);
  textAlign(LEFT);
  textSize(16);
  text(text, x + 20, y + 30);
}

void drawStudentsListening() {
  float[] studentX = {width/2 - 200, width/2, width/2 + 200};
  float studentY = height - 180;
  
  for (int i = 0; i < 3; i++) {
    drawStudentListening(studentX[i], studentY, i);
  }
}

void drawStudentListening(float x, float y, int studentId) {
  pushMatrix();
  translate(x, y);
  
  // Listening animation
  float listenBob = sin(millis() * 0.005 + studentId * 2) * 2;
  translate(0, listenBob);
  
  // Head turn towards chef
  float headTurn = sin(millis() * 0.003 + studentId) * 0.1;
  rotate(headTurn);
  
  if (studentId == 0) {
    drawStudent1Listening();
  } else if (studentId == 1) {
    drawStudent2Listening();
  } else if (studentId == 2) {
    drawStudent3Listening();
  }
  
  popMatrix();
}

void drawStudent1Listening() {
  // Student 1 listening attentively
  fill(255, 220, 177);
  stroke(200, 180, 150);
  strokeWeight(2);
  ellipse(0, -40, 50, 50);
  
  fill(30, 20, 10);
  noStroke();
  ellipse(0, -50, 55, 45);
  
  fill(255, 220, 177);
  rect(-8, -15, 16, 25);
  
  fill(220, 60, 60);
  stroke(180, 40, 40);
  strokeWeight(2);
  rect(-35, -10, 70, 90, 10);
  
  // Arms in listening position
  fill(220, 60, 60);
  ellipse(-38, 5, 25, 70);
  ellipse(38, 5, 25, 70);
  
  fill(255, 220, 177);
  ellipse(-38, 40, 15, 15);
  ellipse(38, 40, 15, 15);
  
  fill(25, 25, 112);
  stroke(15, 15, 80);
  strokeWeight(2);
  rect(-35, 80, 70, 50);
}

void drawStudent2Listening() {
  // Student 2 listening
  fill(255, 220, 177);
  stroke(200, 180, 150);
  strokeWeight(2);
  ellipse(0, -40, 48, 48);
  
  fill(80, 50, 30);
  noStroke();
  ellipse(0, -50, 52, 42);
  ellipse(0, -70, 15, 35);
  
  fill(255, 100, 150);
  rect(-8, -55, 16, 4, 2);
  
  fill(255, 220, 177);
  rect(-7, -15, 14, 28);
  
  fill(60, 180, 60);
  stroke(40, 140, 40);
  strokeWeight(2);
  rect(-32, -8, 64, 85, 10);
  
  fill(60, 180, 60);
  ellipse(-33, 3, 22, 65);
  ellipse(33, 3, 22, 65);
  
  fill(255, 220, 177);
  ellipse(-33, 37, 12, 12);
  ellipse(33, 37, 12, 12);
  
  fill(25, 25, 112);
  stroke(15, 15, 80);
  strokeWeight(2);
  rect(-32, 77, 64, 45);
}

void drawStudent3Listening() {
  // Student 3 listening
  fill(255, 220, 177);
  stroke(200, 180, 150);
  strokeWeight(2);
  ellipse(0, -40, 55, 52);
  
  fill(60, 40, 20);
  noStroke();
  ellipse(0, -52, 60, 48);
  
  fill(70, 50, 30);
  for (int i = 0; i < 8; i++) {
    float angle = i * PI/4;
    float curlyX = cos(angle) * 25;
    float curlyY = sin(angle) * 20 - 52;
    ellipse(curlyX, curlyY, 8, 12);
  }
  
  fill(255, 220, 177);
  rect(-10, -15, 20, 25);
  
  fill(60, 120, 220);
  stroke(40, 90, 180);
  strokeWeight(2);
  rect(-38, -8, 76, 95, 12);
  
  fill(60, 120, 220);
  ellipse(-40, 7, 28, 72);
  ellipse(40, 7, 28, 72);
  
  fill(255, 220, 177);
  ellipse(-40, 43, 16, 16);
  ellipse(40, 43, 16, 16);
  
  fill(25, 25, 112);
  stroke(15, 15, 80);
  strokeWeight(2);
  rect(-38, 87, 76, 48);
}

void drawChefInfoBoard() {
  float boardX = width/2 - 150;
  float boardY = 50;
  float boardW = 300;
  float boardH = 200;
  
  // Board shadow
  fill(0, 0, 0, 30);
  rect(boardX + 5, boardY + 5, boardW, boardH, 15);
  
  // Board frame
  fill(101, 67, 33);
  stroke(80, 50, 20);
  strokeWeight(3);
  rect(boardX - 10, boardY - 10, boardW + 20, boardH + 20, 15);
  
  // Board surface
  fill(25, 60, 25);
  stroke(20, 45, 20);
  strokeWeight(2);
  rect(boardX, boardY, boardW, boardH, 10);
  
  // Text
  fill(255, 255, 255, 220);
  textAlign(CENTER);
  textSize(24);
  text("Chef Budi", boardX + boardW/2, boardY + 40);
  
  stroke(255, 255, 255, 180);
  strokeWeight(2);
  line(boardX + 30, boardY + 50, boardX + boardW - 30, boardY + 50);
  noStroke();
  
  textAlign(LEFT);
  textSize(16);
  fill(255, 255, 255, 200);
  text("• Ahli masakan tradisional", boardX + 20, boardY + 80);
  text("• 15 tahun pengalaman", boardX + 20, boardY + 105);
  text("• Spesialisasi: Rendang", boardX + 20, boardY + 130);
  text("• Pisang Ijo, Coto, Papeda", boardX + 20, boardY + 155);
  text("• Asal: Jakarta", boardX + 20, boardY + 180);
}

// Scene 5-8 Functions
void drawChefCooking() {
  // Chef diposisikan di tengah-tengah layar
  float chefX = width/2;
  float chefY = height/2; // Posisi tengah vertikal
  
  if (imagesLoaded && chefImg != null) {
    imageMode(CENTER);
    pushMatrix();
    translate(chefX, chefY);
    
    // Cooking animation
    float cookingGesture = sin(millis() * 0.02) * 0.2;
    rotate(cookingGesture);
    
    // Stirring motion
    float stirringBob = sin(millis() * 0.03) * 4;
    translate(0, stirringBob);
    
    image(chefImg, 0, 0, 280, 380); // Diperbesar dari 200x270
    popMatrix();
    
  } else {
    // Placeholder chef cooking
    fill(255, 255, 255);
    stroke(200);
    strokeWeight(3);
    rect(chefX - 80, chefY - 120, 160, 240, 15);
    
    fill(0);
    textAlign(CENTER);
    textSize(18);
    text("CHEF", chefX, chefY - 130);
    text("Memasak", chefX, chefY - 105);
  }
  
  // Cooking pot di dekat chef
  drawCookingPot(chefX - 60, chefY - 100);
}

void drawCookingPot(float x, float y) {
  // Pot body (lebih besar dan menonjol)
  fill(80, 80, 80);
  stroke(60, 60, 60);
  strokeWeight(3);
  ellipse(x + 50, y + 30, 80, 60);
  
  // Pot lid (lebih besar)
  fill(70, 70, 70);
  ellipse(x + 50, y + 5, 70, 20);
  
  // Steam (lebih banyak dan lebih tinggi)
  fill(200, 200, 200, 150);
  noStroke();
  for (int i = 0; i < 7; i++) {
    float steamX = x + 25 + i * 8;
    float steamY = y - 15 - sin(millis() * 0.01 + i) * 6;
    ellipse(steamX, steamY, 8, 15);
  }
  
  // Handle (lebih tebal)
  stroke(60, 60, 60);
  strokeWeight(4);
  line(x + 10, y + 15, x + 90, y + 15);
}

// Gambar rendang sederhana
void drawSimpleRendang() {
  // Piring rendang sederhana
  float plateX = width/2 + 150;
  float plateY = height/2 + 50;
  
  // Piring
  fill(255, 255, 255);
  stroke(220, 220, 220);
  strokeWeight(3);
  ellipse(plateX, plateY, 80, 80);
  
  // Rendang di atas piring
  if (imagesLoaded && rendangImg != null) {
    imageMode(CENTER);
    image(rendangImg, plateX, plateY, 60, 60);
    imageMode(CORNER);
  } else {
    // Placeholder rendang
    fill(139, 69, 19);
    noStroke();
    ellipse(plateX, plateY, 50, 40);
  }
}

void drawPisangIjo() {
  // Gambar pisang ijo di sebelah kanan (dipindah ke kiri sedikit)
  float pisangX = width - 300; // Digeser ke kiri dari 200 ke 300
  float pisangY = height/2;
  
  // Piring pisang ijo (diperbesar lagi)
  fill(255, 255, 255);
  stroke(220, 220, 220);
  strokeWeight(3);
  ellipse(pisangX, pisangY, 220, 220);
  
  // Gambar pisang ijo (diperbesar lagi)
  if (imagesLoaded && pisangijoImg != null) {
    imageMode(CENTER);
    image(pisangijoImg, pisangX, pisangY, 200, 200);
    imageMode(CORNER);
  } else {
    // Placeholder pisang ijo (diperbesar lagi)
    fill(34, 139, 34);
    noStroke();
    ellipse(pisangX, pisangY, 150, 125);
    
    // Detail pisang ijo (diperbesar lagi)
    fill(50, 205, 50);
    ellipse(pisangX - 25, pisangY - 12, 38, 50);
    ellipse(pisangX + 25, pisangY + 12, 38, 50);
    ellipse(pisangX, pisangY + 25, 50, 38);
  }
}






  






























































void keyPressed() {
  if (key == ENTER || key == RETURN) {
    nextScene();
  }
  
  if (key >= '1' && key <= '9') {
    currentScene = key - '0';
    if (currentScene > totalScenes) {
      currentScene = totalScenes;
    }
    resetCurrentScene();
  }
  
  if (key == '0') {
    currentScene = 8;
    resetCurrentScene();
  }
  
  if (key == ' ') {
    resetCurrentScene();
  }
}

void nextScene() {
  currentScene++;
  if (currentScene > totalScenes) {
    currentScene = 1;
  }
  resetCurrentScene();
}

void resetCurrentScene() {
  switch(currentScene) {
    case 1:
      isRinging = true;
      ringCount = 0;
      ringTimer = 0;

      break;
    case 2:
      teacherArmAngle = 0;
      for (int i = 0; i < 3; i++) {
        studentBlink[i] = 0;
        blinkTimer[i] = 0;
      }
      break;
    case 3:
      chefWalkX = -50; // Mulai dari posisi yang lebih dekat
      chefWalking = true;
      break;
    case 4:
      chefIntroTimer = 0;
      introStep = 0;
      break;
    case 5:
      modernKitchenTimer = 0;
      ingredientFloatY = 0;
      steamEffect = 0;
      floatingParticles.clear();
      break;
    case 6:
      traditionalKitchenTimer = 0;
      gudegFloatY = 0;
      traditionalSteamEffect = 0;
      traditionalParticles.clear();
      break;
    case 7:
      rusticKitchenTimer = 0;
      papedaFloatY = 0;
      rusticSteamEffect = 0;
      rusticParticles.clear();
      break;
    case 8:
      // Reset variabel untuk Scene 8 (berdasarkan Scene 3)
      chefWalkX = -50; // Mulai dari posisi yang lebih dekat
      chefWalking = true;
      break;

    default:
      break;
  }
}

void mousePressed() {
  nextScene();
}

// ===== SCENE 6: TRADITIONAL KITCHEN WITH GUDEG THEME =====

class TraditionalParticle {
  float x, y, vx, vy, life, maxLife;
  color particleColor;
  
  TraditionalParticle(float x, float y, color c) {
    this.x = x;
    this.y = y;
    this.vx = random(-0.5, 0.5);
    this.vy = random(-1.5, -0.3);
    this.life = 255;
    this.maxLife = 255;
    this.particleColor = c;
  }
  
  void update() {
    x += vx;
    y += vy;
    life -= 2;
    vy *= 0.99;
  }
  
  void display() {
    if (life > 0) {
      float alpha = map(life, 0, maxLife, 0, 255);
      fill(red(particleColor), green(particleColor), blue(particleColor), alpha);
      noStroke();
      ellipse(x, y, 3, 3);
    }
  }
  
  boolean isDead() {
    return life <= 0;
  }
}

void drawTraditionalKitchenBackground() {
  // Background gradient tradisional dengan nuansa hangat
  for (int i = 0; i < height; i++) {
    float inter = map(i, 0, height, 0, 1);
    color c = lerpColor(color(255, 248, 220), color(245, 235, 200), inter);
    stroke(c);
    line(0, i, width, i);
  }
  
  // Lantai kayu tradisional
  fill(139, 115, 85);
  stroke(120, 95, 65);
  strokeWeight(2);
  for (int i = 0; i < width; i += 30) {
    line(i, height - 80, i, height);
  }
  
  // Dinding dengan wallpaper tradisional
  fill(255, 250, 240);
  stroke(245, 240, 230);
  strokeWeight(1);
  rect(0, 0, width, height - 80);
  
  // Pattern dinding tradisional
  stroke(235, 230, 220);
  strokeWeight(0.5);
  for (int i = 0; i < width; i += 80) {
    for (int j = 0; j < height - 80; j += 80) {
      point(i, j);
    }
  }
  
  // Kabinet atas tradisional dengan kayu jati
  fill(101, 67, 33);
  stroke(80, 50, 20);
  strokeWeight(2);
  rect(40, 40, width - 80, 70, 8);
  
  // Handle kabinet tradisional
  fill(139, 69, 19);
  stroke(101, 67, 33);
  strokeWeight(1);
  for (int i = 0; i < 3; i++) {
    rect(70 + i * 150, 50, 80, 6, 3);
  }
  
  // Kabinet bawah tradisional
  fill(120, 80, 40);
  stroke(101, 67, 33);
  strokeWeight(2);
  rect(40, height - 180, width - 80, 100, 8);
  
  // Counter top kayu
  fill(160, 120, 80);
  stroke(139, 115, 85);
  strokeWeight(3);
  rect(40, height - 200, width - 80, 20, 5);
  
  // Backsplash tradisional
  fill(255, 245, 235);
  stroke(245, 235, 225);
  strokeWeight(1);
  rect(40, 110, width - 80, 90);
  
  // Pattern backsplash tradisional
  stroke(235, 225, 215);
  strokeWeight(0.5);
  for (int i = 0; i < width - 80; i += 30) {
    for (int j = 0; j < 90; j += 30) {
      point(40 + i, 110 + j);
    }
  }
}

void drawChefWithImageScene6() {
  // Chef dengan gambar chef.png seperti di scene 5
  float chefX = width/2;
  float chefY = height/2; // Posisi tengah seperti scene 5
  
  // Update animasi
  traditionalKitchenTimer += 0.05;
  
  if (imagesLoaded && chefImg != null) {
    imageMode(CENTER);
    pushMatrix();
    translate(chefX, chefY);
    
    // Slight movement untuk animasi
    float chefBob = sin(traditionalKitchenTimer * 2) * 2;
    translate(0, chefBob);
    
    // Slight rotation untuk efek hidup
    float chefRotate = sin(traditionalKitchenTimer * 1.5) * 0.02;
    rotate(chefRotate);
    
    image(chefImg, 0, 0, 280, 380); // Ukuran sama seperti scene 5
    popMatrix();
    imageMode(CORNER);
  } else {
    // Placeholder jika gambar tidak ada
    fill(255, 255, 255);
    stroke(200);
    strokeWeight(3);
    rect(chefX - 140, chefY - 190, 280, 380, 15);
    
    fill(0);
    textAlign(CENTER);
    textSize(20);
    text("CHEF BUDI", chefX, chefY - 130);
    text("Ahli Masakan", chefX, chefY - 100);
    text("Tradisional", chefX, chefY - 75);
  }
}

void drawTraditionalCookingEquipment() {
  // Tungku tradisional
  float stoveX = width/2 - 120;
  float stoveY = height - 160;
  
  // Base tungku
  fill(80, 60, 40);
  stroke(60, 45, 30);
  strokeWeight(3);
  rect(stoveX, stoveY, 100, 70, 10);
  
  // Lubang api tradisional
  fill(40, 30, 20);
  stroke(30, 20, 10);
  strokeWeight(2);
  ellipse(stoveX + 25, stoveY + 20, 30, 30);
  ellipse(stoveX + 75, stoveY + 20, 30, 30);
  
  // Api tradisional
  float flameIntensity = sin(traditionalKitchenTimer * 4) * 0.3 + 0.7;
  fill(255, 140, 0, 180 * flameIntensity);
  noStroke();
  ellipse(stoveX + 25, stoveY + 20, 20 * flameIntensity, 20 * flameIntensity);
  ellipse(stoveX + 75, stoveY + 20, 20 * flameIntensity, 20 * flameIntensity);
  
  // Kuali tradisional
  float panX = width/2 + 80;
  float panY = height - 170;
  
  // Kuali tembaga
  fill(184, 115, 51);
  stroke(160, 100, 40);
  strokeWeight(2);
  ellipse(panX, panY, 70, 25);
  
  // Handle kuali
  fill(139, 69, 19);
  stroke(101, 67, 33);
  strokeWeight(1);
  rect(panX + 30, panY - 4, 25, 8, 4);
  
  // Uap dari kuali
  traditionalSteamEffect += 0.08;
  for (int i = 0; i < 6; i++) {
    float steamX = panX + random(-25, 25);
    float steamY = panY - 20 - sin(traditionalSteamEffect + i) * 12;
    float steamSize = random(4, 10);
    
    fill(220, 220, 220, 120);
    noStroke();
    ellipse(steamX, steamSize, steamSize, steamSize);
  }
  
  // Cobek dan ulekan tradisional
  float cobekX = width/2 + 200;
  float cobekY = height - 160;
  
  // Cobek batu
  fill(120, 120, 120);
  stroke(100, 100, 100);
  strokeWeight(2);
  ellipse(cobekX, cobekY, 40, 15);
  
  // Ulekan kayu
  fill(139, 69, 19);
  stroke(101, 67, 33);
  strokeWeight(1);
  rect(cobekX - 3, cobekY - 25, 6, 25, 3);
}

void drawGudegWithImage() {
  // Gambar gudeg dengan gudeg.png
  float gudegX = width/2 + 200;
  float gudegY = height/2 + 50;
  
  // Piring gudeg (diperbesar seperti rendang di scene 5)
  fill(255, 255, 255);
  stroke(220, 220, 220);
  strokeWeight(3);
  ellipse(gudegX, gudegY, 180, 180); // Ukuran sama seperti rendang di scene 5
  
  // Gambar gudeg
  if (imagesLoaded && gudegImg != null) {
    imageMode(CENTER);
    image(gudegImg, gudegX, gudegY, 150, 150); // Ukuran sama seperti rendang di scene 5
    imageMode(CORNER);
  } else {
    // Placeholder gudeg
    fill(139, 69, 19);
    noStroke();
    ellipse(gudegX, gudegY, 120, 90);
    
    // Detail gudeg
    fill(160, 82, 45);
    ellipse(gudegX - 20, gudegY - 12, 35, 40);
    ellipse(gudegX + 20, gudegY + 12, 35, 40);
  }
}

void drawTraditionalKitchenAmbience() {
  // Lighting effects tradisional
  float lightIntensity = sin(traditionalKitchenTimer * 0.4) * 0.15 + 0.85;
  
  // Lampu minyak tradisional
  fill(255, 255, 200, 40 * lightIntensity);
  noStroke();
  ellipse(width/2, 120, 150, 80);
  
  // Ambient glow tradisional
  fill(255, 250, 240, 15 * lightIntensity);
  rect(0, 0, width, height);
  
  // Aksesori dapur tradisional
  // Gentong air
  float gentongX = width - 120;
  float gentongY = height - 160;
  
  fill(139, 69, 19);
  stroke(101, 67, 33);
  strokeWeight(2);
  ellipse(gentongX, gentongY, 50, 60);
  
  // Tutup gentong
  fill(160, 82, 45);
  stroke(139, 69, 19);
  strokeWeight(1);
  ellipse(gentongX, gentongY - 25, 40, 15);
  
  // Rak bumbu tradisional
  float rackX = 120;
  float rackY = height - 160;
  
  fill(101, 67, 33);
  stroke(80, 50, 20);
  strokeWeight(2);
  rect(rackX - 30, rackY, 60, 40, 5);
  
  // Botol bumbu
  for (int i = 0; i < 3; i++) {
    fill(255, 255, 255);
    stroke(200, 200, 200);
    strokeWeight(1);
    ellipse(rackX - 15 + i * 15, rackY + 15, 8, 15);
  }
  
  // Jam dinding tradisional
  fill(139, 69, 19);
  stroke(101, 67, 33);
  strokeWeight(2);
  ellipse(width/2, 80, 60, 60);
  
  fill(0, 0, 0);
  textAlign(CENTER);
  textSize(12);
  text("12:34", width/2, 85);
}

// ===== SCENE 7: RUSTIC INDUSTRIAL KITCHEN WITH PAPEDA THEME =====

class RusticParticle {
  float x, y, vx, vy, life, maxLife;
  color particleColor;
  
  RusticParticle(float x, float y, color c) {
    this.x = x;
    this.y = y;
    this.vx = random(-0.8, 0.8);
    this.vy = random(-2.0, -0.8);
    this.life = 255;
    this.maxLife = 255;
    this.particleColor = c;
  }
  
  void update() {
    x += vx;
    y += vy;
    life -= 2.5;
    vy *= 0.97;
  }
  
  void display() {
    if (life > 0) {
      float alpha = map(life, 0, maxLife, 0, 255);
      fill(red(particleColor), green(particleColor), blue(particleColor), alpha);
      noStroke();
      ellipse(x, y, 3.5, 3.5);
    }
  }
  
  boolean isDead() {
    return life <= 0;
  }
}

void drawRusticKitchenBackground() {
  // Background gradient rustic dengan nuansa industrial
  for (int i = 0; i < height; i++) {
    float inter = map(i, 0, height, 0, 1);
    color c = lerpColor(color(220, 215, 210), color(200, 195, 190), inter);
    stroke(c);
    line(0, i, width, i);
  }
  
  // Lantai beton industrial
  fill(150, 150, 150);
  stroke(130, 130, 130);
  strokeWeight(2);
  for (int i = 0; i < width; i += 50) {
    for (int j = 0; j < height - 60; j += 50) {
      rect(i, j, 45, 45);
    }
  }
  
  // Dinding bata ekspos
  fill(180, 120, 100);
  stroke(160, 100, 80);
  strokeWeight(1);
  rect(0, 0, width, height - 60);
  
  // Pattern bata
  stroke(160, 100, 80);
  strokeWeight(0.5);
  for (int i = 0; i < width; i += 40) {
    line(i, 0, i, height - 60);
  }
  for (int j = 0; j < height - 60; j += 25) {
    line(0, j, width, j);
  }
  
  // Kabinet atas industrial
  fill(80, 80, 80);
  stroke(60, 60, 60);
  strokeWeight(2);
  rect(30, 30, width - 60, 80, 5);
  
  // Handle kabinet industrial
  fill(120, 120, 120);
  stroke(100, 100, 100);
  strokeWeight(1);
  for (int i = 0; i < 4; i++) {
    rect(60 + i * 100, 45, 60, 8, 4);
  }
  
  // Kabinet bawah industrial
  fill(90, 90, 90);
  stroke(70, 70, 70);
  strokeWeight(2);
  rect(30, height - 200, width - 60, 120, 5);
  
  // Counter top stainless steel
  fill(200, 200, 200);
  stroke(180, 180, 180);
  strokeWeight(3);
  rect(30, height - 220, width - 60, 20, 3);
  
  // Backsplash industrial
  fill(160, 160, 160);
  stroke(140, 140, 140);
  strokeWeight(1);
  rect(30, 110, width - 60, 110);
  
  // Pattern backsplash industrial
  stroke(140, 140, 140);
  strokeWeight(0.5);
  for (int i = 0; i < width - 60; i += 25) {
    for (int j = 0; j < 110; j += 25) {
      point(30 + i, 110 + j);
    }
  }
}

void drawChefWithImageScene7() {
  // Chef dengan gambar chef.png seperti di scene 5 dan 6
  float chefX = width/2;
  float chefY = height/2; // Posisi tengah seperti scene 5 dan 6
  
  // Update animasi
  rusticKitchenTimer += 0.05;
  
  if (imagesLoaded && chefImg != null) {
    imageMode(CENTER);
    pushMatrix();
    translate(chefX, chefY);
    
    // Slight movement untuk animasi
    float chefBob = sin(rusticKitchenTimer * 2) * 2;
    translate(0, chefBob);
    
    // Slight rotation untuk efek hidup
    float chefRotate = sin(rusticKitchenTimer * 1.5) * 0.02;
    rotate(chefRotate);
    
    image(chefImg, 0, 0, 280, 380); // Ukuran sama seperti scene 5 dan 6
    popMatrix();
    imageMode(CORNER);
  } else {
    // Placeholder jika gambar tidak ada
    fill(255, 255, 255);
    stroke(200);
    strokeWeight(3);
    rect(chefX - 140, chefY - 190, 280, 380, 15);
    
    fill(0);
    textAlign(CENTER);
    textSize(20);
    text("CHEF BUDI", chefX, chefY - 130);
    text("Ahli Masakan", chefX, chefY - 100);
    text("Tradisional", chefX, chefY - 75);
  }
}

void drawRusticCookingEquipment() {
  // Kompor industrial
  float stoveX = width/2 - 130;
  float stoveY = height - 170;
  
  // Base kompor industrial
  fill(60, 60, 60);
  stroke(40, 40, 40);
  strokeWeight(3);
  rect(stoveX, stoveY, 120, 80, 8);
  
  // Burner industrial
  fill(40, 40, 40);
  stroke(30, 30, 30);
  strokeWeight(2);
  ellipse(stoveX + 30, stoveY + 25, 35, 35);
  ellipse(stoveX + 90, stoveY + 25, 35, 35);
  
  // Api industrial
  float flameIntensity = sin(rusticKitchenTimer * 3) * 0.4 + 0.6;
  fill(255, 120, 0, 200 * flameIntensity);
  noStroke();
  ellipse(stoveX + 30, stoveY + 25, 25 * flameIntensity, 25 * flameIntensity);
  ellipse(stoveX + 90, stoveY + 25, 25 * flameIntensity, 25 * flameIntensity);
  
  // Panci industrial
  float panX = width/2 + 100;
  float panY = height - 180;
  
  // Panci stainless steel industrial
  fill(220, 220, 220);
  stroke(200, 200, 200);
  strokeWeight(2);
  ellipse(panX, panY, 80, 30);
  
  // Handle panci industrial
  fill(180, 180, 180);
  stroke(160, 160, 160);
  strokeWeight(1);
  rect(panX + 35, panY - 5, 30, 10, 5);
  
  // Uap dari panci
  rusticSteamEffect += 0.06;
  for (int i = 0; i < 7; i++) {
    float steamX = panX + random(-30, 30);
    float steamY = panY - 25 - sin(rusticSteamEffect + i) * 15;
    float steamSize = random(5, 12);
    
    fill(210, 210, 210, 130);
    noStroke();
    ellipse(steamX, steamY, steamSize, steamSize);
  }
  
  // Grinder industrial
  float grinderX = width/2 + 220;
  float grinderY = height - 170;
  
  // Base grinder
  fill(70, 70, 70);
  stroke(50, 50, 50);
  strokeWeight(2);
  rect(grinderX - 20, grinderY, 40, 50, 6);
  
  // Container grinder
  fill(200, 200, 200, 180);
  stroke(180, 180, 180);
  strokeWeight(1);
  ellipse(grinderX, grinderY - 10, 30, 40);
  
  // Button grinder
  fill(255, 80, 80);
  stroke(200, 60, 60);
  strokeWeight(1);
  ellipse(grinderX, grinderY + 20, 10, 10);
}

void drawPapedaWithImage() {
  // Gambar papeda dengan papedaImg
  float papedaX = width/2 + 200;
  float papedaY = height/2 + 50;
  
  // Piring papeda (diperbesar seperti rendang di scene 5)
  fill(255, 255, 255);
  stroke(220, 220, 220);
  strokeWeight(3);
  ellipse(papedaX, papedaY, 180, 180); // Ukuran sama seperti rendang di scene 5
  
  // Gambar papeda
  if (imagesLoaded && papedaImg != null) {
    imageMode(CENTER);
    image(papedaImg, papedaX, papedaY, 150, 150); // Ukuran sama seperti rendang di scene 5
    imageMode(CORNER);
  } else {
    // Placeholder papeda
    fill(139, 69, 19);
    noStroke();
    ellipse(papedaX, papedaY, 120, 90);
    
    // Detail papeda
    fill(160, 82, 45);
    ellipse(papedaX - 20, papedaY - 12, 35, 40);
    ellipse(papedaX + 20, papedaY + 12, 35, 40);
  }
}

void drawRusticKitchenAmbience() {
  // Lighting effects industrial
  float lightIntensity = sin(rusticKitchenTimer * 0.3) * 0.25 + 0.75;
  
  // Lampu industrial
  fill(255, 255, 220, 50 * lightIntensity);
  noStroke();
  ellipse(width/2, 100, 180, 90);
  
  // Ambient glow industrial
  fill(220, 215, 210, 20 * lightIntensity);
  rect(0, 0, width, height);
  
  // Aksesori dapur industrial
  // Exhaust fan industrial
  float fanX = width - 100;
  float fanY = 120;
  
  fill(80, 80, 80);
  stroke(60, 60, 60);
  strokeWeight(2);
  ellipse(fanX, fanY, 60, 60);
  
  // Blade fan
  fill(100, 100, 100);
  stroke(80, 80, 80);
  strokeWeight(1);
  for (int i = 0; i < 4; i++) {
    pushMatrix();
    translate(fanX, fanY);
    rotate(radians(i * 90 + rusticKitchenTimer * 20));
    rect(-2, -20, 4, 40, 2);
    popMatrix();
  }
  
  // Storage rack industrial
  float rackX = 100;
  float rackY = height - 170;
  
  fill(70, 70, 70);
  stroke(50, 50, 50);
  strokeWeight(2);
  rect(rackX - 40, rackY, 80, 50, 4);
  
  // Storage containers
  for (int i = 0; i < 3; i++) {
    fill(180, 180, 180);
    stroke(160, 160, 160);
    strokeWeight(1);
    rect(rackX - 30 + i * 20, rackY + 10, 15, 30, 2);
  }
  
  // Digital display industrial
  fill(0, 0, 0);
  stroke(50, 50, 50);
  strokeWeight(2);
  rect(width/2 - 40, 70, 80, 40, 5);
  
  fill(0, 255, 0);
  textAlign(CENTER);
  textSize(14);
  text("12:34", width/2, 95);
}
