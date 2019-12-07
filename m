Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1F3115A42
	for <lists+linux-nvdimm@lfdr.de>; Sat,  7 Dec 2019 01:30:00 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ED1411011351E;
	Fri,  6 Dec 2019 16:33:20 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::442; helo=mail-wr1-x442.google.com; envelope-from=adamhana1907@gmail.com; receiver=<UNKNOWN> 
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1DF8F1011351C
	for <linux-nvdimm@lists.01.org>; Fri,  6 Dec 2019 16:33:17 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id z7so9559315wrl.13
        for <linux-nvdimm@lists.01.org>; Fri, 06 Dec 2019 16:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=S7m9By4/eRnSy0vxdfJ6TocT5eJ8gcKLceyHvlHTn3o=;
        b=LXxoS6Ed7of6jWaofmDfQc8/u3Mg9Maolmr3Vpf9Rmy6M9EqjFAuvGQ8h9p7LhnwAL
         J2FbblgdkGgZHafRFxx28eRdV2u28AyUlEZcVvHuYvVm3rtf1quwzUCMSvqmMRhzvXWg
         Lr2BVgHFftpJuxoM6FIG7HwvD6NJoH8mvEjpjvV8POe7OxPQSgcaMvRkWz9Uiu2DLDQI
         zLbCM6eF/2UqhYCC9SzqWLAqDFWNhNPH2Mzqdx7SMOIQYQVzi+r4mUYfVbZ4zkg6G/Rf
         GMyYZz2zxEAODyOdyEtKF6h6LvlYj6nQy3cPNK/qqQ+yOafhqpdxqfrrNrKMk4+XdZU4
         ueNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=S7m9By4/eRnSy0vxdfJ6TocT5eJ8gcKLceyHvlHTn3o=;
        b=MH/0xs6sBwc/TFY50VYCqq2HsJW6o1qni88UeQWPDO7nOAydUhmEjXHx9YO8zJYQG/
         cff3k8bJtxmGXI+wwWBvCyuERTPa/+nlvtGpiAPiyORmMdolBS1HTzJiEYp1n4USj5Tr
         DE5mOWVN2lC3EWNUDHj2Xz64d9rAG5MG353ZQKJ2GjoN0QsaKDKJul6FRsqKsA3ovteB
         Q69nZU0ucTeW6CgLVG9A+Ftiil2cylkiJCE7WAgVt7MV8MXGJzJLhqIz3qAAKkEBSB9y
         08Q7ayUKEfDyRJ5W1O4fYS9qAULPXjZmRavj5VSOtoAS0yAk0F/Zktruwx/EdBAA92eY
         /wFQ==
X-Gm-Message-State: APjAAAVSJVbxdvxs5kpRhOlUI844VhV4ePMmRZqDCT+Y/voafrrFrNaV
	XcnTBsFGDgRKvHmKFU+/nQ/CcceBoz/A//oOdsc=
X-Google-Smtp-Source: APXvYqwrh3pZjAB0r+TmXxbhmAM/apODdHlIT+82DMPTCRz8CUTTqPzcZB7T3FAp1SOvDrWQKKNsT0CStxod+O7hBLs=
X-Received: by 2002:adf:e591:: with SMTP id l17mr16654604wrm.139.1575678594023;
 Fri, 06 Dec 2019 16:29:54 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a5d:678e:0:0:0:0:0 with HTTP; Fri, 6 Dec 2019 16:29:53 -0800 (PST)
From: "Mrs.Aalia.Ahmed" <adamhana1907@gmail.com>
Date: Sat, 7 Dec 2019 00:29:53 +0000
Message-ID: <CAOGreO=8t36s1Mau26bRqTQErHsnOf5ki10AJ6EA4tNedNUo8g@mail.gmail.com>
Subject: OK
To: undisclosed-recipients:;
Message-ID-Hash: FVOQAFYOQH32HKXAZGFAEM2MMPRHUFCF
X-Message-ID-Hash: FVOQAFYOQH32HKXAZGFAEM2MMPRHUFCF
X-MailFrom: adamhana1907@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: mrs.aalia.ahmed@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FVOQAFYOQH32HKXAZGFAEM2MMPRHUFCF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Greetings My Dearest One.

My name is Mrs.Aalia.Ahmed, i saw your profile and became interested
in you, please contact me through my email address
(mrs.aalia.ahmed@gmail.com) to know each other and i have something
very important to tell you, i wait for your response to my email ID.
(mrs.aalia.ahmed@gmail.com
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
