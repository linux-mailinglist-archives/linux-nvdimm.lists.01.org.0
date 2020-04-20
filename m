Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF101B0C76
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 Apr 2020 15:20:54 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8061F10106312;
	Mon, 20 Apr 2020 06:20:46 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::343; helo=mail-wm1-x343.google.com; envelope-from=pankaj.gupta.linux@gmail.com; receiver=<UNKNOWN> 
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BED12100DBB0B
	for <linux-nvdimm@lists.01.org>; Mon, 20 Apr 2020 06:19:59 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u16so2734498wmc.5
        for <linux-nvdimm@lists.01.org>; Mon, 20 Apr 2020 06:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HbALYnvj9b7TiRQ6HAqBN8J26z1aInuwy6QTO8EMY+I=;
        b=jZm2UUq2zjNKVHP1+m+OOsr9+zzuILrI7wjwY/9JrBC5piC62jvTTbtdcvDr9INl5c
         6icvBQX98bCQRu4iSJsSZApWvmr9ZbCLWZibrXkn7wS5xb4e4C/ICOiHI1nfJqBWgp0d
         4qTYn9ur/ZTZBgha/eYrZZSX66bQhU0MdiEZKMgkLZrNeMzerZlHcijPpDLb8OH2pXNx
         D3WmPygjrnuLAc4GkBS6NRVvtMcyThcUucBOLoxUz8vZzhlNREGq0ZRcrkPfcjJJv4tP
         ZopbxiAhBhhg+RoiiIfB7G0QZc3GfPTkCE7VrzT6ma8YlFY0I6lDZkttm2Cc4A0j7zZC
         Wwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HbALYnvj9b7TiRQ6HAqBN8J26z1aInuwy6QTO8EMY+I=;
        b=JuFt6GoqhQZYunFpNoDxogZ6vqmS2S1Vct5v3ByMWZE8mEXXvT/DMMJB7By0wVkF2B
         t55wGihF3FcvjWfwvnqlgnc4NCpR2n7wJrk9NsgWpM0yUMU5TljKzBPd94Otyk9JbRT9
         kANuwvwLR96bsMyKXlfVU9mMpgBncz5fe9aHpH+NxU8hNtxEzoEGDslQIgfz8fVZaIN1
         1GKim76eH/WCOTOVWnF8LFulIKAO5EIf7oVOmVXQiWwaFTYCMbejIRKpkA/ZQWmut69/
         qz799Ev9NarcJylfuDsmHDFsvx9xCpMvz1WPYD36kgTKBIzmua9VXkpaj6rBDX6TLFD0
         SHaw==
X-Gm-Message-State: AGi0PuakgjvqYPaEW9WvLyOkx4u8Qlog6L+JJ6bMN747x3hqUxgyzFcI
	HYNT6e7WIzYs9+n/9BCZP6A=
X-Google-Smtp-Source: APiQypJ3sBXuI4PxATAUoiduk4LKotXHhIwDCjwHAeKuon8DwwJa/VWAxVcq9SgNV9e+kI3dEVCx4w==
X-Received: by 2002:a05:600c:2c04:: with SMTP id q4mr16987057wmg.7.1587388802106;
        Mon, 20 Apr 2020 06:20:02 -0700 (PDT)
Received: from PC192-168-2-103.speedport.ip (p5B05E57B.dip0.t-ipconnect.de. [91.5.229.123])
        by smtp.gmail.com with ESMTPSA id z76sm1545815wmc.9.2020.04.20.06.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 06:20:01 -0700 (PDT)
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-nvdimm@lists.01.org
Subject: [RFC 0/2] virtio-pmem: Asynchronous flush
Date: Mon, 20 Apr 2020 15:19:45 +0200
Message-Id: <20200420131947.41991-1-pankaj.gupta.linux@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Message-ID-Hash: JFZDO4TJHRT63Z2KCATIAR5ZRWGLLQIN
X-Message-ID-Hash: JFZDO4TJHRT63Z2KCATIAR5ZRWGLLQIN
X-MailFrom: pankaj.gupta.linux@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: david@redhat.com, mst@redhat.com, pankaj.gupta@cloud.ionos.com, Pankaj Gupta <pankaj.gupta.linux@gmail.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JFZDO4TJHRT63Z2KCATIAR5ZRWGLLQIN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

 Jeff reported preflush order issue with the existing implementation
 of virtio pmem preflush. Dan suggested[1] to implement asynchronous flush
 for virtio pmem using work queue as done in md/RAID. This patch series
 intends to solve the preflush ordering issue and also makes the flush
 asynchronous from the submitting thread POV.

 Submitting this patch series for feeback and is in WIP. I have
 done basic testing and currently doing more testing.

Pankaj Gupta (2):
  pmem: make nvdimm_flush asynchronous
  virtio_pmem: Async virtio-pmem flush

 drivers/nvdimm/nd_virtio.c   | 66 ++++++++++++++++++++++++++----------
 drivers/nvdimm/pmem.c        | 15 ++++----
 drivers/nvdimm/region_devs.c |  3 +-
 drivers/nvdimm/virtio_pmem.c |  9 +++++
 drivers/nvdimm/virtio_pmem.h | 12 +++++++
 5 files changed, 78 insertions(+), 27 deletions(-)

[1] https://marc.info/?l=linux-kernel&m=157446316409937&w=2
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
