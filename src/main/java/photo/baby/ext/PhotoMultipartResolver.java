package photo.baby.ext;

import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.multipart.MultipartException;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by apple on 16/3/29.
 */
public class PhotoMultipartResolver extends CommonsMultipartResolver {

    private static final long maxUploadSize = 1048576000;
    private static final int maxInMemorySize = 4096;

    private ProgressListener pl;

    public PhotoMultipartResolver(ProgressListener pl) {
        super();
        this.pl = pl;
        setMaxUploadSize(maxUploadSize);
        setMaxInMemorySize(maxInMemorySize);
    }

    public MultipartParsingResult parseRequest(HttpServletRequest request) throws MultipartException {
        String encoding = this.determineEncoding(request);
        FileUpload fileUpload = prepareFileUpload(encoding);
        fileUpload.setProgressListener(pl);
        try {
            List<FileItem> fileItems = ((ServletFileUpload) fileUpload).parseRequest(request);
            return parseFileItems(fileItems, encoding);
        } catch (FileUploadBase.SizeLimitExceededException ex) {
            throw new MaxUploadSizeExceededException(fileUpload.getSizeMax(), ex);
        } catch (FileUploadException ex) {
            throw new MultipartException("Could not parse multipart servlet request", ex);
        }
    }
}
