require_relative '../lib/airport.rb'

describe Airport do
  let(:plane) { double :plane }
  let(:plane2) { double :plane2 } # Not sure of better way
  let(:airport) { Airport.new(5) }

  describe '#capacity' do
    it 'should confirm default capacity is set to 10.' do
      expect(subject.capacity).to eq Airport::DEFAULT_CAPACITY
    end

    it 'should allow user to set the docking station capacity' do
      5.times { airport.land(be_an_instance_of plane) }
      expect{ airport.land(plane) }.to raise_error 'Hangar full.'
    end
  end

  describe '#land' do
    it { is_expected.to respond_to(:land).with(1).argument }

    it 'should store a plane in hangar when landed' do
      expect(subject.land(plane)).not_to be_empty
    end

    it 'raises an error when hangar is full.' do
      Airport::DEFAULT_CAPACITY.times { subject.land(be_an_instance_of plane) }
      expect { subject.land(plane) }.to raise_error 'Hangar full.'
    end

    it 'should raise error if grounded plane tries landing again.' do
      subject.land(plane)
      expect { subject.land(plane) }.to raise_error 'Plane already grounded.'
    end
  end

  describe '#take_off' do
    it { is_expected.to respond_to(:take_off).with(1).argument }

    it 'should remove plane from airport' do
      subject.land(plane)
      expect(subject.take_off(plane)).to eq plane
    end

    it 'raises an error when there are no planes in the hangar' do
      expect { subject.take_off(plane) }.to raise_error 'No planes in hangar.'
    end

    it 'should raise error if flying plane tries take_off again.' do
      subject.land(plane)
      expect { subject.take_off(plane2) }.to raise_error 'Plane already flying.'
    end
  end
end