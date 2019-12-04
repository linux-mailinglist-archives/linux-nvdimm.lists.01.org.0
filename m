Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9A51128AB
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Dec 2019 10:56:10 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DD60310113322;
	Wed,  4 Dec 2019 01:59:30 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B4CF710113320
	for <linux-nvdimm@lists.01.org>; Wed,  4 Dec 2019 01:59:27 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id l22so3384363pff.9
        for <linux-nvdimm@lists.01.org>; Wed, 04 Dec 2019 01:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zqIFvknQVVWjCMELbETkLgBAyF0ovBu36Fa6DQI5rv8=;
        b=TjCCFwfqaqpqxq5WNbCAmNGWEv9afEJfHr1LHZdFI+mMxlwk4zcuLPx+t/D8nB2gtj
         jKO6ZMS0bkNgTtBtg02LT1LsF7+QzTq3gn90bw3qkhAI0IStot9Og/T27dsNoHLEe2T+
         VfCxKN4eMUyOG9CWz8SLx5wA+RpayXrUD8x+Ya99AdF+3zUpTKkDmogpMAHymm2Z+kAb
         q55ucbXjJoW9hIGRdnzpoCpOun/9S180I1Z0PaIIJyGRN7oGV+wrWQitkVCNR5BG6xuv
         d5VfJREzXxemWd+whmJjPodEGHtTHPPRnfcPVdgVSclojAxyWQZX1MHgqYVrPSj387tS
         ZsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zqIFvknQVVWjCMELbETkLgBAyF0ovBu36Fa6DQI5rv8=;
        b=dgaAxF7xx3swDU8clp1IlUhWQSjQOh0qKyN8h7oSKv8YP0k4ECosPvfrFTokPYAvJK
         CzHVFvNxhEf3Tp5fWNI1NwMw1AMytQ40XFAT5zVk1SnQJIcDC1pMZ6ypG/t3m9C2T+Ab
         7ejNJfQno7ILIrGAIqsCTF6Kmvu0vZi/8SDvIKyVYdeYhSAhslVaY6ger4eXs75ZJ8QQ
         6FAJ8rmvVMU9cC5yAsQKeHd50od9fC97StTH5lNBEgIjS3yc4N6fZbydDQR3TQMqnjQ7
         JXQ10TU8JlzUw9abMJcXOZUOHZ7oYIEwYXYKhm8xCYOoode0PbVlabmfZ2karbNK+Kyy
         dRiw==
X-Gm-Message-State: APjAAAUYLdrJ8ofdjhQn8DZqXe9P7DC1f3570WJ71OzTGwewKxmC+npt
	UJq+slDbSJ0xrEydRphMswLa4rRysWY=
X-Google-Smtp-Source: APXvYqwiPQaXOGiV61b7TmqUCSVpcgcCxdJFCDbEnie7P2ecQHMkvykuG8Pt0ofTNKwUO2HUoRbgWA==
X-Received: by 2002:a62:1d90:: with SMTP id d138mr2630175pfd.223.1575453364360;
        Wed, 04 Dec 2019 01:56:04 -0800 (PST)
Received: from santosiv.in.ibm.com ([129.41.84.69])
        by smtp.gmail.com with ESMTPSA id h68sm7834198pfe.162.2019.12.04.01.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 01:56:03 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: linux-nvdimm@lists.01.org,
	Vishal Verma <vishal.l.verma@intel.com>,
	vaibhav@linux.ibm.com
Cc: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH ndctl] namespace/create: Don't create multiple namespace unless greedy
Date: Wed,  4 Dec 2019 15:25:53 +0530
Message-Id: <20191204095553.83209-1-santosh@fossix.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Message-ID-Hash: BKY3N7HOT45FZZ5C3KJOERONJ4F5EC5M
X-Message-ID-Hash: BKY3N7HOT45FZZ5C3KJOERONJ4F5EC5M
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BKY3N7HOT45FZZ5C3KJOERONJ4F5EC5M/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Vaibhav Jain <vaibhav@linux.ibm.com>

Currently create-namespace creates two namespaces with the '-f' option
even without the greedy flag. This behavior got introduced by
c75f7236d. The earlier behaviour was to create one namespace even with
the '-f' flag. The earlier behavior:

$ sudo ./ndctl/ndctl create-namespace -s 16M -f
[sudo] password for santosh:
{
  "dev":"namespace1.14",
  "mode":"fsdax",
  "map":"dev",
  "size":"14.00 MiB (14.68 MB)",
  "uuid":"03f6b921-7684-4736-b2be-87f021996e52",
  "sector_size":512,
  "align":65536,
  "blockdev":"pmem1.14"
}

After greedy option was introduced:

$ sudo ./ndctl/ndctl create-namespace -s 16M -f
{
  "dev":"namespace1.8",
  "mode":"fsdax",
  "map":"dev",
  "size":"14.00 MiB (14.68 MB)",
  "uuid":"1a9d6610-558b-454e-8b95-76c6201798cb",
  "sector_size":512,
  "align":65536,
  "blockdev":"pmem1.8"
}
{
  "dev":"namespace0.3",
  "mode":"fsdax",
  "map":"dev",
  "size":"14.00 MiB (14.68 MB)",
  "uuid":"eed9d28b-69a2-4c7c-9503-24e8aee87b1e",
  "sector_size":512,
  "align":65536,
  "blockdev":"pmem0.3"
}

If no region or '-c' flag is specified bail out if the creation was successful.

Fixes: c75f7236d (ndctl/namespace: add a --continue option to create namespaces greedily)
Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 ndctl/namespace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index 7fb0007..8098456 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -1392,6 +1392,8 @@ static int do_xaction_namespace(const char *namespace,
 				if (force) {
 					if (rc)
 						saved_rc = rc;
+					else if (!param.region)
+							return rc;
 					continue;
 				}
 				return rc;
-- 
2.23.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
