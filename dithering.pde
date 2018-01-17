PImage my_image;
PImage my_image2;
int factor;
float w, mX;


void setup() {
  size(1024, 512);
  my_image2 = loadImage("wallpaper.jpg");
  my_image = loadImage("wallpaper.jpg");
  //my_image.filter(GRAY);
  image(my_image2, 0, 0);
  factor = 1;
  w = width;
  mX = mouseX;
}

int index(int x, int y) {
  return x + y * my_image.width;
}

void draw() {
  my_image.loadPixels();
  
  for (int y = 0; y < my_image.height-1; y++) {
    for (int x = 1; x < my_image.width-1; x++) {
      color pix = my_image2.pixels[index(x,y)];
      
      float oldR = red(pix);
      float oldG = green(pix);
      float oldB = blue(pix);
      
      int newR = round(factor * oldR / 255) * (255 / factor);
      int newG = round(factor * oldG / 255) * (255 / factor);
      int newB = round(factor * oldB / 255) * (255 / factor);

      my_image.pixels[index(x,y)] = color(newR, newG, newB);
      
      float errR = oldR - newR;
      float errG = oldG - newG;
      float errB = oldB - newB;
      
      int idx = index(x+1, y);
      color c = my_image2.pixels[idx];
      float r = red(c)   + errR * 7/16.0;
      float g = green(c) + errG * 7/16.0;
      float b = blue(c)  + errB * 7/16.0;
      my_image.pixels[idx] = color(r, g, b);
      
      idx = index(x-1, y+1);
      c = my_image2.pixels[idx];
      r = red(c)   + errR * 3/16.0;
      g = green(c) + errG * 3/16.0;
      b = blue(c)  + errB * 3/16.0;
      my_image.pixels[idx] = color(r, g, b);
      
      idx = index(x, y+1);
      c = my_image2.pixels[idx];
      r = red(c)   + errR * 5/16.0;
      g = green(c) + errG * 5/16.0;
      b = blue(c)  + errB * 5/16.0;
      my_image.pixels[idx] = color(r, g, b);
      
      idx = index(x+1, y+1);
      c = my_image2.pixels[idx];
      r = red(c)   + errR * 1/16.0;
      g = green(c) + errG * 1/16.0;
      b = blue(c)  + errB * 1/16.0;
      my_image.pixels[idx] = color(r, g, b);
    }
  }
  
  my_image.updatePixels();
  image(my_image, 512, 0);
}

void mouseClicked() {
  mX = mouseX;
  factor = round((mX/w) * 255.0);
  if(factor < 1) {
    factor = 1;
  }
  else if (factor > 255) {
    factor = 255;
  }
  println("factor: " + factor);
}