function varargout = PalmRecognition(varargin)
% PALMRECOGNITION MATLAB code for PalmRecognition.fig
%      PALMRECOGNITION, by itself, creates a new PALMRECOGNITION or raises the existing
%      singleton*.
%
%      H = PALMRECOGNITION returns the handle to a new PALMRECOGNITION or the handle to
%      the existing singleton*.
%
%      PALMRECOGNITION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PALMRECOGNITION.M with the given input arguments.
%
%      PALMRECOGNITION('Property','Value',...) creates a new PALMRECOGNITION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PalmRecognition_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PalmRecognition_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PalmRecognition

% Last Modified by GUIDE v2.5 07-Jun-2018 08:21:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PalmRecognition_OpeningFcn, ...
                   'gui_OutputFcn',  @PalmRecognition_OutputFcn, ...
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


% --- Executes just before PalmRecognition is made visible.
function PalmRecognition_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PalmRecognition (see VARARGIN)

% Choose default command line output for PalmRecognition
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PalmRecognition wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PalmRecognition_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in B_open.
function B_open_Callback(hObject, eventdata, handles)
% hObject    handle to B_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global image

image = {};

[filename, pathname] = uigetfile({'*.jpg';'*.bmp';'*.png';},'Pilih Gambar');

if ~isequal(filename,0)
    image = imread(fullfile(pathname, filename));
    
    guidata(hObject,handles);
    axes(handles.G1);
    imshow(image);
else
    return;
end


% --- Executes on button press in B_recog.
function B_recog_Callback(hObject, eventdata, handles)
% hObject    handle to B_recog (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global image
global neuralnet

if (isempty(image))
    msgbox('Please open palm image');
    return
end

prep_image = imrotate(image, 90);
    
prep_image = imresize(prep_image, [NaN 640]);

[feature, palmImage, overLBImage] = extract_features(prep_image, 0);
lbpFeatures = extractLBPFeatures(rgb2gray(image), 'Upright', true);

feature = [feature lbpFeatures]

guidata(hObject,handles);
axes(handles.G2);
imshow(palmImage);

guidata(hObject,handles);
axes(handles.G3);
imshow(overLBImage);

owner = recognize(neuralnet, feature')
set(handles.T_nama, 'String', owner);
% --- Executes on button press in B_train.
function B_train_Callback(hObject, eventdata, handles)
% hObject    handle to B_train (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global neuralnet

neuralnet = train('datasets\');
