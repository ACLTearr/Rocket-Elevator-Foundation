require 'elevator_media'

describe ElevatorMedia::Streamer do
    context 'test' do
        it 'tests working so far' do
            media = ElevatorMedia::Streamer.new
            expect(media). to be_kind_of(ElevatorMedia::Streamer)
        end
    end
end