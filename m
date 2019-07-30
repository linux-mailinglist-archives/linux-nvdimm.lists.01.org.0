Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B68F7B507
	for <lists+linux-nvdimm@lfdr.de>; Tue, 30 Jul 2019 23:32:58 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 53B92212E4B7E;
	Tue, 30 Jul 2019 14:35:27 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::242; helo=mail-oi1-x242.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 6B998212E4B76
 for <linux-nvdimm@lists.01.org>; Tue, 30 Jul 2019 14:35:25 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id s184so49031126oie.9
 for <linux-nvdimm@lists.01.org>; Tue, 30 Jul 2019 14:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=l81RXxL6m1M+gQi+SuAd5R2wSnsgJIHKcsPpxRaT+zY=;
 b=kSraaR/B69E6goTJThqCvMC1ZhsMD0N0w5q1jMLfSN0GHoz9vXAU3m3AHpz+4wmTv9
 tZVIuOs+jj6t6MKaNVnGTZ2VTUi8L/JxKeE0owWWiPnLaW80y1l+DnNHx0apvNfSQYcn
 WmWRi1t5Fnl1S/v5DtX5uqZhbC1jM6F6MFn4Hylizm80YJWY73wGSkEw4N9/Sta7mnMq
 AZZChJkjeOlN5igrm3Ge5gAZg4nniJlq4pAJGB+P2nDXgZ4gduMWAX9ePkqXE2l3g9ry
 OdB63Wq+ER+sZeLgyUEkg7LddjpE89nFO+sdaVyCnc3IDz/7Y67x+Ketii1q7IPt3qHD
 7rAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=l81RXxL6m1M+gQi+SuAd5R2wSnsgJIHKcsPpxRaT+zY=;
 b=obQSwVMjqmph1dmamlCcCtChjTXzlIwyyTnk46FCiRT2OKamre7o92WxKyOAvRp9/y
 n9wMSniuthMCQNDH/f4vFyII8rjKhWGKaQk+8zO8GrRJeIwZ+6b3ghCivCkki2xzhOPy
 IcbiGaceHcs+Hi+Kyzikn+YvqMHkL3Pq0kp8Onb5BhFxHjPFKNbzDSmHm8jLWERBFYts
 amved6SqlcnmZuNZEgCitsivf61rA3eD2OdANV48Uno0Tk042LSPgPStY9sF1DGcikDv
 /eMvLdYMvAM3/1Oi4mMZcnvWZMEeYZuWFjyEH5/bYgrnLROh/cz1HqQKRnf7gXCnv9QG
 y0Vw==
X-Gm-Message-State: APjAAAUXtgcPhUAwBRiJWDppN6q18omYUTzd+DLPnndL6+c79gXhuZLF
 dSRUnkWK9XrQ9zoqWThPE/+biAyXOI1xHafGeyXG4w==
X-Google-Smtp-Source: APXvYqxegpyFwvFejPXoYEYiHMinVR1/8uYTEPVTdMw6CR76L0x5Au3WV2IYjBoYTv7Ebh0VDCCNGBi0AhckDvlWDPg=
X-Received: by 2002:aca:ba02:: with SMTP id k2mr1920323oif.70.1564522373532;
 Tue, 30 Jul 2019 14:32:53 -0700 (PDT)
MIME-Version: 1.0
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 30 Jul 2019 14:32:42 -0700
Message-ID: <CAPcyv4hJcRY3aop4jgH8NLsz1A8HH7sH6gnGs02Wy8A=p5o=jg@mail.gmail.com>
Subject: [GIT PULL] dax fix for v5.3-rc3
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
Cc: Jan Kara <jack@suse.cz>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm dax-fix-5.3-rc3

...to receive a manual fixup I happened to drop. I re-fetched the
patch from the mailing list after integrating the git message-id
support to generate a "Link:" tag [1], but then did not re-apply the
fixup. This now matches what I tested and went into yesterday's -next.

[1]: https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2019-July/006608.html

---

The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:

  Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm dax-fix-5.3-rc3

for you to fetch changes up to 61c30c98ef17e5a330d7bb8494b78b3d6dffe9b8:

  dax: Fix missed wakeup in put_unlocked_entry() (2019-07-29 09:24:22 -0700)

----------------------------------------------------------------
dax fix 5.3-rc3

- Fix a botched manual patch update that got dropped between testing and
  application.

----------------------------------------------------------------
Jan Kara (1):
      dax: Fix missed wakeup in put_unlocked_entry()

 fs/dax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

---

diff --git a/fs/dax.c b/fs/dax.c
index a237141d8787..b64964ef44f6 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -266,7 +266,7 @@ static void wait_entry_unlocked(struct xa_state
*xas, void *entry)
 static void put_unlocked_entry(struct xa_state *xas, void *entry)
 {
        /* If we were the only waiter woken, wake the next one */
-       if (entry && dax_is_conflict(entry))
+       if (entry && !dax_is_conflict(entry))
                dax_wake_entry(xas, entry, false);
 }
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
