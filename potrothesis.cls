\def\versionno{0.01}
\def\versiondate{2024/06/01}


% --- Core Setup & Configuration ---
\input{modules/core/setup}
\input{modules/core/compatibility}
\input{modules/core/options}
\input{modules/core/localization}

% --- Layout & Design ---
\input{modules/layout/geometry}
\input{modules/layout/colors}
\input{modules/layout/fonts}
\input{modules/layout/toc-patches}
\input{modules/layout/captions}
\input{modules/layout/tagging}
\input{modules/layout/hyper}

% --- Metadata Variables & User Commands ---
\input{modules/metadata/degree-date}
\input{modules/metadata/author}
\input{modules/metadata/supervisor}
\input{modules/metadata/acceptor}
\input{modules/metadata/reader}
\input{modules/metadata/degree}
\input{modules/metadata/copyright}
\input{modules/metadata/title}
\input{modules/metadata/signature}

% --- Layout Renderers ---
\input{modules/pages/title}
\input{modules/pages/committee}
\input{modules/pages/abstract}

% --- Utilities & Environments ---
\input{modules/utils/footnotes}
\input{modules/utils/nomenclature}

\endinput