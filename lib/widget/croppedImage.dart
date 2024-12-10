const String cloudinaryCloudName = 'your-cloud-name'; // Replace with your Cloudinary cloud name
const String defaultBizImage = 'https://res.cloudinary.com/drwt2qqf9/image/upload/c_fill,h_500,w_500,q_auto/v1721488956/default-img_vhxk4d.jpg'; // Replace with your default image URL

String constructBizImgUrl(String? publicId, {String? type}) {
  if (publicId == null || publicId.isEmpty) {
    return defaultBizImage;
  }

  if (type == "meta") {
    return "https://res.cloudinary.com/$cloudinaryCloudName/image/upload/c_fill,h_500,w_500,q_auto:low,f_auto/$publicId.jpg";
  } else {
    return "https://res.cloudinary.com/$cloudinaryCloudName/image/upload/c_fill,q_auto:low/$publicId.jpg";
  }
}
