require 'elevator_media'

#Weather for Montreal taken from https://weatherwidget.io/
weather = '<div> <a class="weatherwidget-io" href="https://forecast7.com/en/45d50n73d57/montreal/" data-label_1="MONTREAL" data-label_2="WEATHER" data-theme="original" >MONTREAL WEATHER</a> <script> !function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="https://weatherwidget.io/js/widget.min.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","weatherwidget-io-js"); </script> </div>'

describe ElevatorMedia::Streamer do

    context 'Create Streamer object' do
        it 'should instantiate an instance of Streamer successfuly' do
            streamer = ElevatorMedia::Streamer.new
            expect(streamer).to be_an_instance_of(ElevatorMedia::Streamer)
        end
    end

    context 'Check that getContent' do
        it 'is available' do
            expect(ElevatorMedia::Streamer).to respond_to(:getContent)
        end
    end

    context 'Check that getContent' do
        it 'returns a string' do
            expect(ElevatorMedia::Streamer.getContent()).to be_a(String)
        end
    end

    context 'Check that getContent' do
        it 'returns inside of a div tag' do
            expect(ElevatorMedia::Streamer.getContent()).to include('div')
        end
    end

    context 'Check that getContent' do
        it 'returns weather for Montreal in a div' do
            expect(ElevatorMedia::Streamer.getContent()).to eq(weather)
        end
    end
end