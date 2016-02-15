function save_colormap(fname, dpath)
%	SAVE_COLORMAP	現在のカラーマップを独自の関数として保存する。
%
%	SAVE_COLORMAP()は，現在のカレントFigureのカラーマップを独自の関数mycolormap()として作成し，
%	カレントディレクトリにmycolormap.mを保存します。
%
%	SAVE_COLORMAP(FUNCNAME)は，現在のカレントFigureのカラーマップを独自の関数FUNCNAMEとして作成し，
%	カレントディレクトリにFUNCNAME.mを保存します。
%
%	SAVE_COLORMAP(FNAME, DPATH)は，現在のカレントFigureのカラーマップを独自の関数FNAMEとして作成し，
%	指定したディレクトリDPATHにFUNCNAME.mを保存します。
%
%	FUNCNAMEとして空行列を渡した場合は，SAVE_COLORMAP('mycolormap', DPATH)と同じことになります。
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
    error('第2引数は文字列である必要があります。');
end;

if exist(dpath,'dir')==0
    error('指定したディレクトリがありません。');
end;

% ディレクトリのパスのチェック
%[dirname, filename, ext, versn] = fileparts(dpath);
[dirname, filename] = fileparts(dpath);
[~,pathinfo] = fileattrib(fullfile(dirname, filename));
%pathinfo = fileattrib(fullfile(dirname, filename));
if pathinfo.directory~=1
    error('第2引数がディレクトリのパスではありません。');
end;
fpath = fullfile(pathinfo.Name, strcat([fname, '.m']));

if all(exist(fpath,'builtin')~=[0,2])
    error('指定しているファイルのパスが、組み込みのMATLAB関数と同じです。');
end;

% 現在のカラーマップの取得
fgh = get(0,'CurrentFigure');
if isempty(fgh)
    error('カレントのFigureがありません。');
end;
ccl = get(fgh,'colormap');

% カラーマップの書き込み
fh = fopen(fpath, 'w');
fprintf(fh, '%s%s%s\n%s', 'function CMAP = ', fname, '()', 'cols = [' );
fprintf(fh, '%d ',ccl);
fprintf(fh, '%s\n%s\n%s', '];', 'CMAP = reshape(cols, floor(length(cols)/3), 3);');
fclose(fh);
