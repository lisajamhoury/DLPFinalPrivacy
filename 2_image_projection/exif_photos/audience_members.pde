class AudienceMember { 
  PImage img;
  boolean dataSet = false;
  JSONObject data = new JSONObject();
  String filename;
  int lts = 0;

  AudienceMember(String imagePath, String iFilename) {
    img = loadImage(imagePath);
    filename = iFilename;
  }

  void display() {
    syphonCanvas.beginDraw();
    syphonCanvas.imageMode(CORNERS);
    //syphonCanvas.image(img, width, 0.1*height, width-img.width, height+img.height);
    syphonCanvas.image(img, width, 0, width-img.width, img.height);
    if (dataSet == false) {
      data = getExifData();
      dataSet = true;
    }

    
    String exifDataText = "Associate Record" + "\n\n" + 
        "Filename: " + data.getString("filename") + "\n" +
        "Date: " + data.getString("date") + "\n" +
        "Model: " + data.getString("model") + "\n" + 
        "Latitude: " + data.getFloat("lat") + "\n" + 
        "Longitude: " + data.getFloat("long")  + "\n" + 
        "Altitude: " + data.getFloat("alt");
    drawText(exifDataText, 0.0005*width, 0.1 * height);
    syphonCanvas.endDraw();
  }

  void drawText(String text, float x, float y) {
    howManyLettersToShow();
    syphonCanvas.fill(255,200);
    syphonCanvas.textFont(AlteHaas);
    syphonCanvas.textAlign(RIGHT);
    syphonCanvas.textSize(26);
    if (lts<=text.length()) {
      syphonCanvas.text( text.substring(0, lts), x, y, 350, 300);
    } else {
      syphonCanvas.text(text, x, y, 350, 300);
    }
  }
  
  int howManyLettersToShow(){
    return lts++;
  }

  JSONObject getExifData() {
    JSONObject amImg = new JSONObject();
    for (int i = 0; i < imagesJSON.size(); i++ ) {
      JSONObject singleImg = imagesJSON.getJSONObject(i);
      String tempName = singleImg.getString("filename");
      if (tempName.equals(filename)) {
        println("GOT IT", tempName, filename);
        amImg = singleImg;
      }
    } 
    return amImg;
  }
}