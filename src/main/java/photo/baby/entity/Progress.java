package photo.baby.entity;

import java.io.Serializable;

/**
 * Created by apple on 16/3/29.
 */
public class Progress implements Serializable {

    /**
     * 0:未开始；1:正在上传；2:正在处理；3:完成；-1:上传异常
     */
    private int status = 0;
    private long max = 0; // 文件总大小
    private long now = 0; // 上传进度
    private long save = 0;  // 保存到本地进度

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public long getMax() {
        return max;
    }

    public void setMax(long max) {
        this.max = max;
    }

    public long getNow() {
        return now;
    }

    public void setNow(long now) {
        this.now = now;
    }

    public long getSave() {
        return save;
    }

    public void setSave(long save) {
        this.save = save;
    }
}
