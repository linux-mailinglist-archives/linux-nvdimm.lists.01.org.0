Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFADAC122
	for <lists+linux-nvdimm@lfdr.de>; Fri,  6 Sep 2019 22:00:15 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6BE0920294F2F;
	Fri,  6 Sep 2019 13:01:01 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id F18CF20216B71
 for <linux-nvdimm@lists.01.org>; Fri,  6 Sep 2019 13:01:00 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id b2so6855583otq.10
 for <linux-nvdimm@lists.01.org>; Fri, 06 Sep 2019 13:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=a797GSlScu7TceDm8JT9sMdOWrDRiCOoWgKbIGvEAOE=;
 b=ivjq879MyPjXeuWLQbzp6PpkI+gFVrJF92I5JYQYSOI7wweZURIWNxqsrewFxIlMjl
 YWKsMn04ooxcUoTEoyfzZg6SR3Aq0v8gQo+aZA8xLWmZaxq73KIaJg9LwlKONx3AW1we
 mG2Y6UFWVxanzI+wywN8oQndM4KFLqAuxL4DIJCVrnqvPuq+NVj7Op69hqa+CvdR20ko
 Weyv5tkeJ3jU88p17+WpZqAGcDQo0/aSzZuymFCRk7RhW7VXHcbZ6zfozPz8JukXPI8t
 +r3h58TsR9m5aFf1qMlPJ8+9FsNEWK3id0TM/FzBlZbnb7bzujkLIAVOiAh0nhH242/t
 Wx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=a797GSlScu7TceDm8JT9sMdOWrDRiCOoWgKbIGvEAOE=;
 b=TN9TmjNP2LHN+PujxcTxtozhsL7hW3V27Is9VZkhYi9Xhgn3HxdpiJx7ngno1Fgjw7
 7OvZ8YB4PzxPWeGCN+ip35IyF4b0D0KOYNJXtdnpvtHa9KacKVjYTjwNAym0dIGaWEoM
 r7jBRpFPth3wwBOTdUfT+0GEVHMTeWckdu0z2HOnWWcUmhxsv73tgJ4Xi1y7ol5hldMH
 DuSvA6vBFbkHhXGxok4Ga/g5ZPG2DsJAH0gn+BNWh7Xs7TimEAk3eHlf1k889xwwvuCN
 iLHyp2TRwvkrjLx5/hkXzknz6pJopPM1N2krfBuT0PQDshCvC3ALB+qPDy1QUd0fRAgG
 F++g==
X-Gm-Message-State: APjAAAULTJuxejUqCGJ9dalB3F37q0oa73wFJQSk/ieUVcG1TDTkmIPX
 I5mb2IlZ1sjzmkxIbMYjEvEPMLjVNXD5dLc0Y9Lnew==
X-Google-Smtp-Source: APXvYqwwyf89TmMvDL8rpbSvr9eAas+QJDsbwLJoO4zMfL6iQ4m63v0JMuzagoFlmJsftEQgCE1iprUTYWm3zoEVJcU=
X-Received: by 2002:a9d:6d15:: with SMTP id o21mr9234698otp.363.1567800011694; 
 Fri, 06 Sep 2019 13:00:11 -0700 (PDT)
MIME-Version: 1.0
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 6 Sep 2019 13:00:00 -0700
Message-ID: <CAPcyv4jDWgZDJTAgghrFX1MQXPJX_6jiqsmx9sQUOL7ZaWtk+w@mail.gmail.com>
Subject: [GIT PULL] libnvdimm fix for v5.3-rc8
To: Linus Torvalds <torvalds@linux-foundation.org>
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fix-5.3-rc8

...to receive a fix for a regression introduced in v5.3-rc1. The
latest version has shipped in -next with no reported issues.

---

The following changes since commit a55aa89aab90fae7c815b0551b07be37db359d76:

  Linux 5.3-rc6 (2019-08-25 12:01:23 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fix-5.3-rc8

for you to fetch changes up to 274b924088e93593c76fb122d24bc0ef18d0ddf4:

  libnvdimm/pfn: Fix namespace creation on misaligned addresses
(2019-08-28 10:33:13 -0700)

----------------------------------------------------------------
libnvdimm fix v5.3-rc8

- Restore support for 1GB alignment namespaces, truncate the end of
  misaligned namespaces.

----------------------------------------------------------------
Jeff Moyer (1):
      libnvdimm/pfn: Fix namespace creation on misaligned addresses

 drivers/nvdimm/pfn_devs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
