import ballerina/http;
import ballerina/io;

service / on new http:Listener(9090) {

    // Serve stored QR images
    resource function get qr/[string fileName]() returns string {
        // In a real app, you'd fetch and return the actual QR image or file
        return fileName;
    }

    // Health check endpoint
    resource function get health() returns json {
        return { status: "UP" };
    }
    
    resource function post qr/[string fileName](http:Request req)
        returns http:Response|error {

            string mountPath = "/qr";

        string filePath = mountPath + "/" + fileName;

        byte[]|error payload = req.getBinaryPayload();
        if payload is error {
            http:Response badReq = new;
            badReq.statusCode = 400;
            badReq.setTextPayload("Invalid binary payload");
            return badReq;
        }

        // Write file with required offset parameter
        io:WritableByteChannel channel = check io:openWritableFile(filePath);
        int intResult = check channel.write(payload, 0); // <-- offset 0
        check channel.close();

        http:Response res = new;
        res.statusCode = 201;
        res.setTextPayload("PNG file saved: " + fileName);
        return res;
    }
}
