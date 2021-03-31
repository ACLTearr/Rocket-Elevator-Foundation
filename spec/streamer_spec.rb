require 'elevator_media'

#Weather for Montreal taken from https://weatherwidget.io/
weather = '<div> <a class="weatherwidget-io" href="https://forecast7.com/en/45d50n73d57/montreal/" data-label_1="MONTREAL" data-label_2="WEATHER" data-theme="original" >MONTREAL WEATHER</a> <script> !function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="https://weatherwidget.io/js/widget.min.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","weatherwidget-io-js"); </script> </div>'

describe ElevatorMedia::Streamer do
    context 'Return weather' do
        it 'should return weather for Montreal in a div' do
            expect(ElevatorMedia::Streamer.getContent()).to eq(weather)
        end
    end
end