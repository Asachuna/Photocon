module PhotosHelper
    def get_uploaded_day(photo)
        created_at = photo.created_at.in_time_zone('Tokyo')
        return created_at.strftime("%Y/%m/%d")
    end
end
