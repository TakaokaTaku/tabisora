RSpec.describe ApplicationHelper, type: :helper do
  describe "full_title" do
    context 'title is foobar' do
      it 'displays full title' do
        expect(full_title('foobar')).to eq("foobar | TABISORA")
      end
    end

    context 'title is empty' do
      it 'displays base title only' do
        expect(full_title('')).to eq("TABISORA")
      end
    end

    context 'title is nil' do
      it 'base title only' do
        expect(full_title(nil)).to eq('TABISORA')
      end
    end
  end
end
