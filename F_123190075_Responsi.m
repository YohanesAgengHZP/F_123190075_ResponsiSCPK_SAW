function varargout = F_123190075_Responsi(varargin)
% F_123190075_RESPONSI MATLAB code for F_123190075_Responsi.fig
%      F_123190075_RESPONSI, by itself, creates a new F_123190075_RESPONSI or raises the existing
%      singleton*.
%
%      H = F_123190075_RESPONSI returns the handle to a new F_123190075_RESPONSI or the handle to
%      the existing singleton*.
%
%      F_123190075_RESPONSI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in F_123190075_RESPONSI.M with the given input arguments.
%
%      F_123190075_RESPONSI('Property','Value',...) creates a new F_123190075_RESPONSI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before F_123190075_Responsi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to F_123190075_Responsi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help F_123190075_Responsi

% Last Modified by GUIDE v2.5 26-Jun-2021 10:42:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @F_123190075_Responsi_OpeningFcn, ...
                   'gui_OutputFcn',  @F_123190075_Responsi_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before F_123190075_Responsi is made visible.
function F_123190075_Responsi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to F_123190075_Responsi (see VARARGIN)

% Choose default command line output for F_123190075_Responsi
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes F_123190075_Responsi wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = F_123190075_Responsi_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in bt_proses.
function bt_proses_Callback(hObject, eventdata, handles)
% hObject    handle to bt_proses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = xlsread('DATARUMAH.xlsx','C2:H21');   %pengambilan dataset kolom ke-3 sampai 8
k = [0 1 1 1 1 1];                         %menentukan cost dan benefit, 0 = cost 1 = benefit
w = [0.30 0.20 0.23 0.10 0.07 0.10];       %bobot kriteria dari persen ke desimal
 
%normalisasi matriks
[m, n]=size (x);    %matriks m x n dengan ukuran sebanyak variabel x (input);
R=zeros (m,n);      %membuat matriks R, yang merupakan matriks kosong
Y=zeros (m,n);      %membuat matriks Y, yang merupakan titik kosong
 
for j=1:n 
    if k(j)==1
        R(:,j)=x(:,j)./max(x(:,j)); %kriteria benefit
    else
        R(:,j)=min(x(:,j))./x(:,j); %kriteria cost
    end
end
 
%menghitung normalisasi matriks dengan bobot
for i=1:m
    V(i) = sum(w.*R(i,:));
end
[~,ids] = sort(V,'descend');%pmengurutkan data dengan nilai terbesar ke terkecil
 
%pengambilan dataset kolom ke-2 (nama rumah)
opts = detectImportOptions('DATARUMAH.xlsx');
opts.SelectedVariableNames = (2);
nama = readmatrix('DATARUMAH.xlsx', opts); %membaca file DATARUMAH.xlsx
namaRumah = nama(1:20);                    %membaca matrix nama dari baris ke-1 sampai 20
 
set(handles.tb_hasil,'Data', namaRumah(ids)); %indeks digunakan untuk menampilkan hasil berdasar rankingnya



% --- Executes on button press in bt_tampil.
function bt_tampil_Callback(hObject, eventdata, handles)
% hObject    handle to bt_tampil (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data1 = xlsread('DATARUMAH.xlsx','A2:A21'); %pengambilan dataset 20 baris 
data2 = xlsread('DATARUMAH.xlsx','B2:H21'); %pengambilan dataset 20 baris 
data = [data1 data2]; %pengambilan dataset tanpa menyertakan kolom kedua
set(handles.tb_data,'Data',data); 
