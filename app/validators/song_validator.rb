class SongValidator < ActiveModel::Validator
  def validate(record)
    if record.released
      if record.release_year.nil?
        record.errors[:release_year] << 'Release year cannot be empty if the Song is released'
      elsif record.release_year > DateTime.now.year
        record.errors[:release_year] << 'Release year cannot be in the future'
      end
    end

    if Song.find_by(title: record.title, artist_name: record.artist_name, release_year: record.release_year)
      record.errors[:base] << 'A song cannot be released twice a year.'
    end
  end
end
