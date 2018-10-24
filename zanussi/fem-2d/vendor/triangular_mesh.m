function [ p_riodinati , t_riordinati,I,B ] = triangular_mesh(domain,h)
% triangular_mesh: domain = 'circle' or 'square' or 'airfoil'

if strcmp(domain,'circle')
        fd=@(p) sqrt(sum(p.^2,2))-1;
        [p,t]=distmesh2d(fd,@huniform,h,[-1,-1;1,1],[]);
elseif strcmp(domain,'square')
         fd=@(p) drectangle(p,0,1,0,1);
         [p,t]=distmesh2d(fd,@huniform,h,[0,0;1,1],[0,0;1,0;0,1;1,1]);
elseif strcmp(domain,'airfoil')
       hlead=0.01; htrail=0.04; hmax=10; circx=2; circr=4;
       a=.12/.2*[0.2969,-0.1260,-0.3516,0.2843,-0.1036];
 
       fd=@(p) ddiff(dcircle(p,circx,0,circr),(abs(p(:,2))-polyval([a(5:-1:2),0],p(:,1))).^2-a(1)^2*p(:,1));
       fh=@(p) min(min(hlead+0.3*dcircle(p,0,0,0),htrail+0.3*dcircle(p,1,0,0)),hmax);
 
       fixx=1-htrail*cumsum(1.3.^(0:4)');
       fixy=a(1)*sqrt(fixx)+polyval([a(5:-1:2),0],fixx);
       fix=[[circx+[-1,1,0,0]*circr; 0,0,circr*[-1,1]]'; 0,0; 1,0; fixx,fixy; fixx,-fixy];
       box=[circx-circr,-circr; circx+circr,circr];
       h0=min([hlead,htrail,hmax,h]);
       [p,t]=distmesh2d(fd,fh,h0,box,fix);
else disp('wrong domain'); return
end
    
% riordina: orienta i triangoli e riordina i nodi 
% mettendo prima quelli interni (df <0)
% e in ultimo  quelli di bordo(df =0).

n_nodi = size(p,1);
n_triangoli = size (t,1);


% TO DO: orientamento dei triangoli in senso antiorario

% Riordinamento dei nodi
old2new = zeros(n_nodi,1); % nuova posizione dei nodi con indicizzazione vecchia
new2old = zeros(n_nodi,1); % vecchia posizione dei nodi con indicizzazione nuova
tol = 10^-3;
i_interno = 1;
i_bordo = n_nodi;
for i = 1:n_nodi
    if abs(fd(p(i,:))) < tol
        old2new(i)=i_bordo;
        new2old(i_bordo)=i;
        i_bordo = i_bordo -1;
    else
        old2new(i)=i_interno;
        new2old(i_interno)=i;
        i_interno = i_interno +1;
    end
end
p_riodinati = p(new2old,:);
t_riordinati = old2new(t);
B=[(i_bordo+1):n_nodi];
I=[1:(i_interno-1)];

