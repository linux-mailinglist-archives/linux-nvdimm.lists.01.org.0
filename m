Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BC82C0287
	for <lists+linux-nvdimm@lfdr.de>; Mon, 23 Nov 2020 10:52:59 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5FF58100EC1D2;
	Mon, 23 Nov 2020 01:52:58 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=joseeduma1@gmail.com; receiver=<UNKNOWN> 
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E344B100EC1D0
	for <linux-nvdimm@lists.01.org>; Mon, 23 Nov 2020 01:52:49 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id k5so2142153plt.6
        for <linux-nvdimm@lists.01.org>; Mon, 23 Nov 2020 01:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=hHO86Hw6douevrmO9c/6rtkTpsHlgUBt/84iGNcDuK0=;
        b=Rlwcmw5w9LipplHTEa+m6Mxc8tsJDCe9qDxHnzkgQZIiUgTbn+dLkdqTQFftE+QK4/
         3KV4gYk5SlnmeE6J+0e8e6IRGuAl+0khaVRsaqAUhIxn4Rild+6Dl3w1AuUcGWQ6umkm
         eUyGyYdRJgdJXxNx5KmTsB8ajPZRU9XF2vZEF/c8c3RKhh9zOiJQHBaiXF2oxzv4O8jU
         vnWDj0ZHvMQttGo5FSj+KHmptNUB9veRF94uR+/fDqZhrI6q/VrNTK1RlmVruzXUWaJx
         vaMPL57qpOXN+Fdm6ZfMSNJA7bWmIeVqffZBWhY1643lCnx2BvOxT35dq4EHhItY5O5r
         jQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=hHO86Hw6douevrmO9c/6rtkTpsHlgUBt/84iGNcDuK0=;
        b=DsWw6TiU6yGiknzn05o4MpzkDAFEL/jlrsS1isMCVfNUeQl7Bd23yBF5q/1+vAvXER
         dHPh9a5zt7kASZp+xpkO8rg8ZN0bJf4fS3FG1HShrK4hxr6CcjRspW75wR67415Rw1WH
         UEK9W011VPOnhcq3LrG65OiyPr3hIuRwaWi0Lmp2WU5K0FSqDywKHgUJqPVCB1J9Yhvo
         +TiKztlpFtxcxLOiKj1XaZFHjxZc8v2UyClniFopvDcOALkQj7rzEO2ZL0twZo0B3rx8
         RJ6ulgHcZtFczEHECQGC1f7iSZewy3qoCO+5jYjYbGrCneJicoQKQIaSe21/IWNAg8df
         zCag==
X-Gm-Message-State: AOAM532tErQN5+fz9A1wCYz5zuLpJ2fHyf2YbNg7wCiwXx2rX5vxp4dM
	WexhwhdAhe0JwpFnYd8UW13CXYxjMT9lONlyLtI=
X-Google-Smtp-Source: ABdhPJyLVfWrBEPV2bLo7eSIVFp735Isj4P5WryAECCxCKnjsVY154NLQ4MPn2cs0PDziJSEZDk8j1xjgibaY0o840Y=
X-Received: by 2002:a17:902:144:b029:d7:dbfc:beee with SMTP id
 62-20020a1709020144b02900d7dbfcbeeemr23721987plb.32.1606125169144; Mon, 23
 Nov 2020 01:52:49 -0800 (PST)
MIME-Version: 1.0
From: De Captain <joseeduma1@gmail.com>
Date: Mon, 23 Nov 2020 09:52:37 +0000
Message-ID: <CADBFNSwu-dFgRMEadonqasrRRyLa9bT5Yf7NWYBkei85=E_fRQ@mail.gmail.com>
Subject: Hi
To: undisclosed-recipients:;
Message-ID-Hash: AOFMQ57PHRMVIRJYFIRKNPEBO2IKAVEN
X-Message-ID-Hash: AOFMQ57PHRMVIRJYFIRKNPEBO2IKAVEN
X-MailFrom: joseeduma1@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: captainhab2@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AOFMQ57PHRMVIRJYFIRKNPEBO2IKAVEN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Can you answer my calls?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
