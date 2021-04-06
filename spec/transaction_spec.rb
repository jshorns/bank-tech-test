require 'transaction'

describe Transaction do
    it { is_expected.to respond_to :amount }
    it { is_expected.to respond_to :deposit? }
    it { is_expected.to respond_to :withdrawal? }
    it { is_expected.to respond_to :date }
end