module Blacklight::Marc::Indexer::Formats
  module FormatMap
    def self.map007(v, vals)
      field007hasC = false
      v = v.upcase
      case
      when (v.start_with? 'A')
        vals << (v == 'AD' ? 'Atlas' : 'Map')
      when (v.start_with? 'C')
        case
        when (v == "CA")
          vals << "TapeCartridge"
        when (v == "CB")
          vals << "ChipCartridge"
        when (v == "CC")
          vals << "DiscCartridge"
        when (v == "CF")
          vals << "TapeCassette"
        when (v == "CH")
          vals << "TapeReel"
        when (v == "CJ")
          vals << "FloppyDisk"
        when (v == "CM")
          vals << "CDROM"
        when (v == "C0")
          vals << "CDROM"
        when (v == "CR")
          # Do not return - this will cause anything with an 856 field to be labeled as "Electronic"
          field007hasC = true
        else
          vals << "Software"
        end
      when (v.start_with? 'D')
        vals << 'Globe'
      when (v.start_with? 'F')
        vals << 'Braille'
      when (v.start_with? 'G')
        if (v == "GC")
          vals << "Filmstrip"
        elsif (v == "GD")
          vals << "Filmstrip"
        elsif (v == "GT")
          vals << "Transparency"
        else
          vals << "Slide"
        end
      when (v.start_with? 'H')
        vals << "Microfilm"
      when (v.start_with? 'K')
        case
        when (v == "KC")
          vals << "Collage"
        when (v == "KD")
          vals << "Drawing"
        when (v == "KE")
          vals << "Painting"
        when (v == "KF")
          vals << "Print"
        when (v == "KG")
          vals << "Photonegative"
        when (v == "KJ")
          vals << "Print"
        when (v == "KL")
          vals << "Drawing"
        when (v == "K0")
          vals << "FlashCard"
        when (v == "KN")
          vals << "Chart"
        else
          vals << "Photo"
        end
      when (v.start_with? 'M')
        if (v == "MF")
          vals << "VideoCassette"
        elsif (v == "MR")
          vals << "Filmstrip"
        else
          vals << "MotionPicture"
        end
      when (v.start_with? 'O')
        vals << 'Kit'
      when (v.start_with? 'Q')
        vals << 'MusicalScore'
      when (v.start_with? 'R')
        vals << 'SensorImage'
      when (v.start_with? 'S')
        if (v == "SD")
          vals << "SoundDisc"
        elsif (v == "SS")
          vals << "SoundCassette"
        else
          vals << "SoundRecording"
        end
      when (v.start_with? 'V')
        if (v == "VC")
          vals << "VideoCartridge"
        elsif (v == "VD")
          vals << "VideoDisc"
        elsif (v == "VF")
          vals << "VideoCassette"
        elsif (v == "VR")
          vals << "VideoReel"
        else
          vals << "Video"
        end
      end
      field007hasC
    end

    def self.map_leader(f_000,field007hasC,vals,record)
      f_000 = f_000.upcase
      case
      when (f_000.start_with? 'C')
        vals << "MusicalScore"
      when (f_000.start_with? 'D')
        vals << "MusicalScore"
      when (f_000.start_with? 'E')
        vals << "Map"
      when (f_000.start_with? 'F')
        vals << "Map"
      when (f_000.start_with? 'I')
        vals << "SoundRecording"
      when (f_000.start_with? 'J')
        vals << "MusicRecording"
      when (f_000.start_with? 'K')
        vals << "Photo"
      when (f_000.start_with? 'M')
        vals << "Electronic"
      when (f_000.start_with? 'O')
        vals << "Kit"
      when (f_000.start_with? 'P')
        vals << "Kit"
      when (f_000.start_with? 'R')
        vals << "PhysicalObject"
      when (f_000.start_with? 'T')
        vals << "Manuscript"
      when (f_000.start_with? 'A')
        if f_000 == 'AM'
          vals << ((field007hasC) ? "eBook" : "Book")
        elsif f_000 == 'AS'
          # Look in 008 to determine what type of Continuing Resource
          format_code = Traject::Macros::Marc21.extract_marc_from(record, "008[21]", first: true, default: "").first.upcase
          if format_code == 'N'
            vals << 'Newspaper'
          elsif format_code == 'P'
            vals << 'Journal'
          else
            vals << 'Serial'
          end
        end
      end
      vals
    end
  end
  def get_format(options = {})
    lambda do |record, accumulator, context|
      vals = []
      extractor = Traject::MarcExtractor.new('245h', options)
      extractor.extract(record).select do |v|
        vals << 'Electronic' if v =~ /electronic\sresource/
      end
      unless vals.empty?
        vals.uniq!
        accumulator.concat vals
      else
        field007hasC = false
        extractor = Traject::MarcExtractor.new('007[0-1]', options)
        extractor.extract(record).each {|v| field007hasC ||= FormatMap.map007(v,vals)}
        unless vals.empty?
          vals.uniq!
          accumulator.concat vals
        else
          # check the Leader - this is NOT a repeating field
          # if we find a matching value there, grab it and return.
          FormatMap.map_leader(record.leader[6,2],field007hasC,vals,record)
          unless vals.empty?
            vals.uniq!
            accumulator.concat vals
          else
            FormatMap.map_leader(record.leader[6],field007hasC,vals,record)
            if vals.empty?
              accumulator.concat ['Unknown']
            else
              vals.uniq!
              accumulator.concat vals
            end
          end
        end
      end
    end
  end
end
