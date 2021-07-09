class Chords

    NOTES = ["A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#"]

    attr_reader :key, :notes, :diatonic_chords, :scale, :extended_chords, :secondary_dominants, :running

    def initialize(key)
        @key = key
        @scale = build_scale(key)
        @diatonic_chords = build_chords("pop")
        @extended_chords = build_chords("jazz")
        @secondary_dominants = secondary_dominants_build
        @running = true
    end

    def make_progression
        p "what genre? (I only accept jazz, pop, and none)"
        genre = gets.chomp
        if genre == "jazz"
            options = secondary_dominants + extended_chords
            p "#{extended_chords[0]}    #{options.sample}   #{extended_chords[1]}   #{extended_chords[4]}   #{extended_chords[0]}"
        elsif genre == "pop"
            p "#{diatonic_chords[0]}    #{diatonic_chords.sample}   #{diatonic_chords[3]}   #{diatonic_chords[4]}   #{diatonic_chords[0]}"
        else
            options = secondary_dominants + extended_chords + diatonic_chords
            p "#{options.sample}    #{options.sample}   #{options.sample}   #{options.sample}   #{diatonic_chords[0]}"
        end
    end

    def next_chord_options
        puts "what chord are you on?"
        current_chord = gets.chomp.capitalize
        tonic = [diatonic_chords[0]] + [diatonic_chords[2]] + [diatonic_chords[5]] + 
                [extended_chords[0]] + [extended_chords[2]] + [extended_chords[5]]

        subdominant = [diatonic_chords[1]] + [diatonic_chords[3]] + 
                        [extended_chords[1]] + [extended_chords[3]]

        dominant = [diatonic_chords[4]] + [diatonic_chords[6]] + 
                    [extended_chords[4]] + [extended_chords[6]]
        dominant << "#{diatonic_chords[4]}7"

        if tonic.include?(current_chord)
            system "clear"
            puts "these chords will lift the sound up"
            puts subdominant
            puts
            puts "and these chords will add some tension"
            puts dominant
        elsif subdominant.include?(current_chord)
            system "clear"
            puts "these chords will relax the listener"
            puts tonic
            puts
            puts "and these chords will add some tension"
            puts dominant
        elsif secondary_dominants.include?(current_chord)
            system "clear"
            puts "you saucy minx, here is where that chord WANTS to go, but not where it needs to go."
            i = secondary_dominants.index(current_chord)
            if i == 0
                puts "#{diatonic_chords[3]} and #{extended_chords[3]}"
            elsif i == 1
                puts "#{diatonic_chords[4]} and #{extended_chords[4]}"
            elsif i == 2
                puts "#{diatonic_chords[5]} and #{extended_chords[5]}"
            elsif i == 3
                puts "#{diatonic_chords[1]} and #{extended_chords[1]}"
            elsif i == 4
                puts "#{diatonic_chords[2]} and #{extended_chords[2]}"   
            end
        elsif dominant.include?(current_chord)
            system "clear"
            puts "These will FULLY resolve all the tension you have right now"
            puts tonic
            puts
            puts "while these chords will resolve some of the tension, they won't feel like an ending point."
            puts dominant
        else
            puts "well that's a weird chord. Try this other random weird chord."
            options = diatonic_chords + extended_chords + secondary_dominants
            puts options.sample
        end
    end

    def function_finder
        p "what sound are you looking for?"
        function = gets.chomp
        if function == "tonic"
            puts "#{diatonic_chords[0]}    #{diatonic_chords[2]}   #{diatonic_chords[5]}   #{extended_chords[0]}    #{extended_chords[2]}   #{extended_chords[5]}"
        elsif function == "subdominant"
            puts "#{diatonic_chords[1]}    #{diatonic_chords[3]}   #{extended_chords[1]}    #{extended_chords[3]}"
        elsif function == "dominant"
            puts "#{diatonic_chords[4]}    #{diatonic_chords[6]}   #{extended_chords[4]}    #{extended_chords[6]}"
        end
    end

    def run
        while running == true
            puts "Here are some commands that work for me"
            puts "list diatonic chords"
            puts "list extended chords"
            puts "list secondary dominants"
            puts "next chord options"
            puts "find this function"
            puts "make a progression"
            command = gets.chomp
            system "clear"
            case command
            when "list diatonic chords"
                puts here you are
                puts diatonic_chords
            end
            puts
            puts
            puts
        end
    end

    private
    def build_scale(key)
        new_arr = []
        build_from = NOTES.rotate(NOTES.index(key))
        new_arr += [build_from[0]] + [build_from[2]] + [build_from[4]] + 
            [build_from[5]] + [build_from[7]] + [build_from[9]] + 
            [build_from[11]]
        new_arr
    end

    def build_chords(genre)
        new_arr = []
        if genre == "pop"
            scale.each_with_index do |note, i|
                if i == 0 || i == 3 || i == 4
                    new_arr << "#{note}"
                elsif i == 1 || i == 2 || i == 5
                    new_arr << "#{note}m"
                else
                    new_arr << "#{note}dim"
                end
            end
            return new_arr
        elsif genre == "jazz"
            scale.each_with_index do |note, i|
                if i == 0 || i == 3
                    new_arr << "#{note}maj7"
                elsif i == 4
                    new_arr << "#{note}7"
                elsif i == 1 || i == 2 || i == 5
                    new_arr << "#{note}m7"
                else
                    new_arr << "#{note}m7b5"
                end
            end
            return new_arr
        end        
    end

    def secondary_dominants_build
        new_arr = []
        scale.each_with_index do |chord, i|
            if i == 0 || i == 1 || i == 2 || i == 5 || i == 6
                new_arr << "#{chord}7"
            end
        end
        new_arr
    end

end

A = Chords.new("D")
puts
puts
A.run
