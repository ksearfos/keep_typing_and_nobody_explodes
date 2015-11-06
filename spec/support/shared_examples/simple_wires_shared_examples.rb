shared_context 'solves_simple_wires_correctly' do
  specify do
    expect do
      described_class.go! wires
    end.to output("Cut the #{target} wire.\n").to_stdout
  end
end
