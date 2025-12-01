import { v2 as cloudinary } from 'cloudinary';
import { Readable } from 'node:stream';

if (process.env.CLOUDINARY_URL) {
  cloudinary.config({
    secure: true,
  });
} else {
  cloudinary.config({
    secure: true,
    cloud_name: process.env.CLOUDINARY_CLOUD_NAME,
    api_key: process.env.CLOUDINARY_API_KEY,
    api_secret: process.env.CLOUDINARY_API_SECRET,
  });
}

export const saveFileToCloudinary = (buffer) => {
  return new Promise((resolve, reject) => {
    const uploadStream = cloudinary.uploader.upload_stream(
      {
        folder: 'students-app/avatars',
        resource_type: 'image',
        overwrite: true,
        unique_filename: true,
        use_filename: false,
      },
      (error, result) => {
        if (error) {
          reject(error);
        } else {
          resolve(result);
        }
      },
    );

    const readableStream = Readable.from(buffer);
    readableStream.pipe(uploadStream);
  });
};
