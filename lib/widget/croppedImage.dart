const String cloudinaryCloudName = 'dshq6chfl'; // Replace with your Cloudinary cloud name
const String cloudinaryApiKey = '877589337471488';
const String defaultBizImage = 'https://res.cloudinary.com/drwt2qqf9/image/upload/c_fill,h_500,w_500,q_auto/v1721488956/default-img_vhxk4d.jpg'; // Replace with your default image URL

// Cloudinary configuration map
final Map<String, String> cloudinaryConfig = {
  'apiKey': cloudinaryApiKey,
  'cloudName': cloudinaryCloudName,
};

// Function to construct the business image URL
String constructBizImgUrl(String? publicId, {String? type}) {
  if (publicId == null || publicId.isEmpty) {
    return defaultBizImage; // Return default image if publicId is null or empty
  }

  if (type == "meta") {
    return "https://res.cloudinary.com/$cloudinaryCloudName/image/upload/c_fill,h_500,w_500,q_auto:low,f_auto/$publicId.jpg";
  } else {
    return "https://res.cloudinary.com/$cloudinaryCloudName/image/upload/c_fill,q_auto:low/$publicId.jpg";
  }
}