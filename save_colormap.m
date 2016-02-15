function save_colormap(fname, dpath)
%	SAVE_COLORMAP	���݂̃J���[�}�b�v��Ǝ��̊֐��Ƃ��ĕۑ�����B
%
%	SAVE_COLORMAP()�́C���݂̃J�����gFigure�̃J���[�}�b�v��Ǝ��̊֐�mycolormap()�Ƃ��č쐬���C
%	�J�����g�f�B���N�g����mycolormap.m��ۑ����܂��B
%
%	SAVE_COLORMAP(FUNCNAME)�́C���݂̃J�����gFigure�̃J���[�}�b�v��Ǝ��̊֐�FUNCNAME�Ƃ��č쐬���C
%	�J�����g�f�B���N�g����FUNCNAME.m��ۑ����܂��B
%
%	SAVE_COLORMAP(FNAME, DPATH)�́C���݂̃J�����gFigure�̃J���[�}�b�v��Ǝ��̊֐�FNAME�Ƃ��č쐬���C
%	�w�肵���f�B���N�g��DPATH��FUNCNAME.m��ۑ����܂��B
%
%	FUNCNAME�Ƃ��ċ�s���n�����ꍇ�́CSAVE_COLORMAP('mycolormap', DPATH)�Ɠ������ƂɂȂ�܂��B
%
% --
%	Title : SAVE_COLORMAP()
%	Author : Sach1o : http://sach1o.blog80.fc2.com/
%	Created : 2007/12/01
% //--

if nargin<1 || isempty(fname)
    fname = 'mycolormap';
end;
if nargin<2
    dpath = pwd;
end;

if ~ischar(dpath)
    error('��2�����͕�����ł���K�v������܂��B');
end;

if exist(dpath,'dir')==0
    error('�w�肵���f�B���N�g��������܂���B');
end;

% �f�B���N�g���̃p�X�̃`�F�b�N
%[dirname, filename, ext, versn] = fileparts(dpath);
[dirname, filename] = fileparts(dpath);
[~,pathinfo] = fileattrib(fullfile(dirname, filename));
%pathinfo = fileattrib(fullfile(dirname, filename));
if pathinfo.directory~=1
    error('��2�������f�B���N�g���̃p�X�ł͂���܂���B');
end;
fpath = fullfile(pathinfo.Name, strcat([fname, '.m']));

if all(exist(fpath,'builtin')~=[0,2])
    error('�w�肵�Ă���t�@�C���̃p�X���A�g�ݍ��݂�MATLAB�֐��Ɠ����ł��B');
end;

% ���݂̃J���[�}�b�v�̎擾
fgh = get(0,'CurrentFigure');
if isempty(fgh)
    error('�J�����g��Figure������܂���B');
end;
ccl = get(fgh,'colormap');

% �J���[�}�b�v�̏�������
fh = fopen(fpath, 'w');
fprintf(fh, '%s%s%s\n%s', 'function CMAP = ', fname, '()', 'cols = [' );
fprintf(fh, '%d ',ccl);
fprintf(fh, '%s\n%s\n%s', '];', 'CMAP = reshape(cols, floor(length(cols)/3), 3);');
fclose(fh);
