Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7DDE57B4
	for <lists+linux-nvdimm@lfdr.de>; Sat, 26 Oct 2019 03:06:39 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1F6F7100EA601;
	Fri, 25 Oct 2019 18:07:48 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::743; helo=mail-qk1-x743.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6DD6B100EEBBA
	for <linux-nvdimm@lists.01.org>; Fri, 25 Oct 2019 18:07:45 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id y189so3491624qkc.3
        for <linux-nvdimm@lists.01.org>; Fri, 25 Oct 2019 18:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=o3JGLijrHeoByp9gbkT6wzfJ5d4fxo3U1OIP57EOzXU=;
        b=HH2SlADzTKXtbikufoaNw2xMGhXgxFdFTMJjuqm1VbQBnGse5SaGJQVEhnRfswGLDr
         DZsduRlDuPzii9l/nQ6zmL6NZzpiay1+Wvm10Z2nXv48LeIzWQvEJtkUcv6eDpAIF+W8
         8hGxvtzeXjRfhZ/9OQexRLn5EnpgWTUEETaJI3HkLlARqurabIq7lq0vVnrQrZLN0axY
         K8+oui+hKlb5sq4M+e8ph58ilX7ZHDzciB/gosbImh92NotXqst+ilD7WxCfKoa9ls6Q
         ZluEDEKyns4GkhkwikX5myoFJV+iV5uUvjQ3lC/Lce+uAWlY4iY2ZNQzIgpfk4BFtuS1
         69bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=o3JGLijrHeoByp9gbkT6wzfJ5d4fxo3U1OIP57EOzXU=;
        b=mxs+jNwuWA3RreZiagiYrB8zj9Y3k85AZwd0DQtn7XdciV3LrVx5c++pjd/t+7fMEJ
         c9zDrELMSD7oZeQsvk4iFUMcLZA2l0v4pA9q4ehK2HUQz8pOUqpe8ZdwcH8VJyo6NpB5
         rQC07YVZ98mqlbUc63H8pP3tvCxHpsZjpYLFiWCQo55KAQqE/kO/na+RaqeiZW1Z0hp1
         fdMzRoqSKI3ss8y6kwKYD5aLrJ9/xoIRHcnloJpLzhQMAqU8w4VwoSNBMFX0VsAzpBus
         YaQcyPD6wrZ9nYGJ2HXvI2I7q6FW525A1cw8axEQpMS7mh4oniTona88eUk2IoACwG7+
         3LgA==
X-Gm-Message-State: APjAAAVYJLpr9FFyGpMRahfTtyw4p4G9xBUUGunndF86Za2k63uydNI9
	RdwGvTZzNsPaRXaw+UhWN4PnqtQow/iDFbnlXMNN/w==
X-Google-Smtp-Source: APXvYqzhFLsroO8pOagwVrVJJjJJYI30TL8mpBBf8YDPfeKcwSfKB9sc6UtodxQ3eDYtEnGo0KP1dCCWsv0HNAclEdE=
X-Received: by 2002:a37:de0c:: with SMTP id h12mr5600689qkj.495.1572051993752;
 Fri, 25 Oct 2019 18:06:33 -0700 (PDT)
MIME-Version: 1.0
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 25 Oct 2019 18:06:22 -0700
Message-ID: <CAPcyv4gi--MyxXOt-vb4Tw+ku=jUYmo4y+YSV+6UJf24BCDAMA@mail.gmail.com>
Subject: [GIT PULL] dax fix for v5.4-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID-Hash: JG5ZFCA34YZ2E4CCVQTNW3FWDBCWXKRB
X-Message-ID-Hash: JG5ZFCA34YZ2E4CCVQTNW3FWDBCWXKRB
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JG5ZFCA34YZ2E4CCVQTNW3FWDBCWXKRB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/dax-fix-5.4-rc5

...to receive a regression fix for v5.4-rc5. It has appeared in a
-next release with no reported issues, and picked up reviews from the
regular dax contributors.

---

The following changes since commit 4f5cafb5cb8471e54afdc9054d973535614f7675:

  Linux 5.4-rc3 (2019-10-13 16:37:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/dax-fix-5.4-rc5

for you to fetch changes up to 6370740e5f8ef12de7f9a9bf48a0393d202cd827:

  fs/dax: Fix pmd vs pte conflict detection (2019-10-22 22:53:02 -0700)

----------------------------------------------------------------
dax fix 5.4-rc5

- Fix a performance regression that followed from a fix to the
  conversion of the fsdax implementation to the xarray. v5.3 users
  report that they stop seeing huge page mappings on an application +
  filesystem layout that was seeing huge pages previously on v5.2.

----------------------------------------------------------------
Dan Williams (1):
      fs/dax: Fix pmd vs pte conflict detection

 fs/dax.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
