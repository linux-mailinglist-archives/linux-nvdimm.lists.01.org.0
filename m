Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 366523317B6
	for <lists+linux-nvdimm@lfdr.de>; Mon,  8 Mar 2021 20:49:54 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 36C05100EBB6B;
	Mon,  8 Mar 2021 11:49:52 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::131; helo=mail-lf1-x131.google.com; envelope-from=zlatkri@gmail.com; receiver=<UNKNOWN> 
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 085A6100EBB6B
	for <linux-nvdimm@lists.01.org>; Mon,  8 Mar 2021 11:49:48 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id m22so22962494lfg.5
        for <linux-nvdimm@lists.01.org>; Mon, 08 Mar 2021 11:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Vf9L8BIDEDCqYmnUAQpjbZKWvYzvN8oTPYZzekAzKtM=;
        b=CfXSP+VGW6JtCKY2dMVWFMChmThBT1LRFxpwyOnMUnDM1XSEtbajXRL0idYtnqvRXI
         K5QypF1E2As+OKgiekqEpxx3TvrGn2XLpJjOo3OUGnRFFoaFLjQO/lNAbPKW3yKJ66ur
         t34B6s6SvGDZiHpl2TYRnAoRTVmXo1B91wtRLQOIQq/b6QeL3cJ6fOuKTn7RPsEJZNQ8
         0m49pJxUc9vrEUDO1B1Z6Wv1ZkC8vTyiDmGB5KkDHjKT6HbMBpmDlXTTeP9sQAzT71nN
         SV15Es2I+d3v9DZ+/eDgi1dQNuCbkZYkZQhjPbnYQLIoHOW2Xe4a1v+7teQJGCIjJt9x
         B/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Vf9L8BIDEDCqYmnUAQpjbZKWvYzvN8oTPYZzekAzKtM=;
        b=FzokvJk1vuU8FdnkZrDIzbw6zgrBow7AHEgVPF6QTjR2IXPd3SQaocC5UwcW46uduo
         3YLyd8epFoFRVadVOfSus8zGLLWVJJVWCsB3Eaj4ixnOOzTJ8un51Kt5Exc5tBkDc+wC
         nK71qsqljEyearMbC9gGI940zWLCBfW66bqiV6WQgeHUgy/FMcmcwLeLAh2jMTJCWz3K
         4VRsJZ3C+i3KYe8wJ5yadOqT050va85Kvpf1f3ygUTChViWWrmPF3YNryOLaMuZOJ5ey
         W9nHZPYWbDIYWH7TAOGhNJPcZufLINJKV58lHh/w6WuggvmEemgvPC5b4SVpnTo3VQFT
         c13w==
X-Gm-Message-State: AOAM531nN4i8s+cOPwCexCNKfl9xsV+JLiXhPpV7mL4MQL4NlsKLBkjz
	xzRdk6/yMYM+ujZYl2tc22KrJWL0Ry5CLS1QQSU=
X-Google-Smtp-Source: ABdhPJylDSgN+Pq1nZsCwf90bazT5R+WZ3u55CtbWdAQC88CNniaS3mbc+BhBgeuZkIOYzFBVuQXVxEfhQclip1qZAA=
X-Received: by 2002:a05:6512:33c9:: with SMTP id d9mr14694291lfg.630.1615232986907;
 Mon, 08 Mar 2021 11:49:46 -0800 (PST)
MIME-Version: 1.0
From: "J. Kirinec" <zlatkri@gmail.com>
Date: Mon, 8 Mar 2021 20:49:34 +0100
Message-ID: <CANq-GdFmUL6d44mXPxQ70qmrn7D3L3Si_uAHNrkZg0Le=D1+EA@mail.gmail.com>
Subject: hi there
To: undisclosed-recipients:;
Message-ID-Hash: C6WZG5QGNMF6BHSIUQP4MWZR6RBSQOMR
X-Message-ID-Hash: C6WZG5QGNMF6BHSIUQP4MWZR6RBSQOMR
X-MailFrom: zlatkri@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: jkirinec101@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/C6WZG5QGNMF6BHSIUQP4MWZR6RBSQOMR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

  Hello there,  How are you today? fine i hope. It's nice to meet you, and
I hope you do not mind me being connected with you in such a way. in actual
fact i was looking for my old friend who reside in your country and that
was when I came across your profile and I decided to write you. My name is
J. Kirinec, USA marine officer. I am in charge of medic. I will like to
hear from you if it so please with you, i believe it's curiosity that
brings me to you in a time like this.  It will be my wish to establish a
very strong relationship with you because I felt the both of us want the
same thing. Once again I must say that I am sorry if the connection with
you contradicts your moral ethics. I look forward to hearing from you.
Regards, J. Kirinec
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
