Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC8E2CA352
	for <lists+linux-nvdimm@lfdr.de>; Tue,  1 Dec 2020 14:02:25 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 95150100EC1D3;
	Tue,  1 Dec 2020 05:02:23 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::144; helo=mail-il1-x144.google.com; envelope-from=pankaj.gupta.linux@gmail.com; receiver=<UNKNOWN> 
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CD234100EC1C9
	for <linux-nvdimm@lists.01.org>; Tue,  1 Dec 2020 05:02:20 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id b8so1544450ila.13
        for <linux-nvdimm@lists.01.org>; Tue, 01 Dec 2020 05:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GujISGwhlbmPBHTK++whZ1M7hVGM+4rvkVOJDvu+Tpw=;
        b=ZbPk4tHwP3WguKetrkTHklUy3UcrKSyWgK6Uym2IZE3wBAOwdVH5c/IDdmwjZPuuqm
         3fBZ1XS0IiiaE//0AYRql3RFisscyQgiDg3DEC725uSg82KNi8qLfcIY1mvrrp0em8t0
         cxqPnFLueiusSfO/++oRYAXbjidQLywBD922gkvVqYDTx9GKI06POfQJ55if1kit6p9l
         cg0MpVzrpdbtvktESIAkHgYo8wSaE+CQbZcaXpPVaoXZGPd0UtmUXya+z7CZOP0Jcy7S
         /Gr2+bDlQj6GL3O6CRxPAO5tEP7e/pd5kFNcYys5eFtWBBHnhM55CGW1MYspSPy7xfnQ
         RBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GujISGwhlbmPBHTK++whZ1M7hVGM+4rvkVOJDvu+Tpw=;
        b=gpHGMhceACwzhM3Zhq7fR4uVR5qwfl9IatSN7D4/r8Gc7iV2gXobIiI2vKn/IM43kz
         m+usMbd285ZQsrbDGYUm0prj7487dTg9oMzD6j3FJIQr5iiuMRQKBicuc6700Q8e1zFt
         3WMww+pmbiaAMv6pRfJkaY0LpXYPxitG6tpMgHx79pAUtfa633XPfkF6PFUVRWJuBYQL
         n6iuPpjwtGT2swTOEEjnaDXoxkVY5ENuPGlW13U2GwJoTzFmZe3JzmRX6H8jCZY+0utu
         iCMIleRymPzxCTgC/9Ec60joRraHsvbNITXs+RypYab83ar/OBqPwwJi0qzrQOrAhQjl
         b/+Q==
X-Gm-Message-State: AOAM532sC0aSDf09R8Vbi/aNvEuKxXqWy7t8Qcd3POKvA3qzyWtl1Fw8
	3xwvnrf13rHc/sK71DHnzqj9tQkunV5lmBkL2QI=
X-Google-Smtp-Source: ABdhPJxpbyyKEZVcWXZZ5bWcz5/0zeLgENsm2YN9RmeGEPYwjqWjjZ85QRhCQWvD9e7ZGl2BamxNDQpt1lIwTNgMtII=
X-Received: by 2002:a92:d40d:: with SMTP id q13mr2324683ilm.253.1606827739426;
 Tue, 01 Dec 2020 05:02:19 -0800 (PST)
MIME-Version: 1.0
References: <160682501436.2579014.14501834468510806255.stgit@lep8c.aus.stglabs.ibm.com>
 <CAM9Jb+iPV470063QYq145znYW8CmqjNgdL=q6=3JXUJJt+z5gw@mail.gmail.com> <20035bbc-a1e0-82fd-105d-999e1afff029@linux.ibm.com>
In-Reply-To: <20035bbc-a1e0-82fd-105d-999e1afff029@linux.ibm.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Tue, 1 Dec 2020 14:02:08 +0100
Message-ID: <CAM9Jb+gS6z603kLwgB62zrHNpLOqW6FAEtDcbwiG5mGRzvZUVg@mail.gmail.com>
Subject: Re: [RFC PATCH] powerpc/papr_scm: Implement scm async flush
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: S6R3HT5J4RMP6GTEQRE5Y3EISQD3LZZX
X-Message-ID-Hash: S6R3HT5J4RMP6GTEQRE5Y3EISQD3LZZX
X-MailFrom: pankaj.gupta.linux@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Shivaprasad G Bhat <sbhat@linux.ibm.com>, ellerman@au1.ibm.com, linux-nvdimm <linux-nvdimm@lists.01.org>, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/S6R3HT5J4RMP6GTEQRE5Y3EISQD3LZZX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> >> Tha patch implements SCM async-flush hcall and sets the
> >> ND_REGION_ASYNC capability when the platform device tree
> >> has "ibm,async-flush-required" set.
> >
> > So, you are reusing the existing ND_REGION_ASYNC flag for the
> > hypercall based async flush with device tree discovery?
> >
> > Out of curiosity, does virtio based flush work in ppc? Was just thinking
> > if we can reuse virtio based flush present in virtio-pmem? Or anything
> > else we are trying to achieve here?
> >
>
>
> Not with PAPR based pmem driver papr_scm.ko. The devices there are
> considered platform device and we use hypercalls to configure the
> device. On similar fashion we are now using hypercall to flush the host
> based caches.

o.k. Thanks for answering.

Best regards,
Pankaj

>
> -aneesh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
