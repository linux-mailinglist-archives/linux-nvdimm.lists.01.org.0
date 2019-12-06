Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6A1114C15
	for <lists+linux-nvdimm@lfdr.de>; Fri,  6 Dec 2019 06:35:35 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 215A41011350D;
	Thu,  5 Dec 2019 21:38:56 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8342D1011350C
	for <linux-nvdimm@lists.01.org>; Thu,  5 Dec 2019 21:38:53 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id l24so2727135pgk.2
        for <linux-nvdimm@lists.01.org>; Thu, 05 Dec 2019 21:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nuvv3ncQRErLqyNpebLTotEX3oMRdLlj8QPJ8M5lSY4=;
        b=QCMydo9iNBpgCltvkx0f3pkSFX8r0e0umpS3xNwErtLJ1GswgurdI9/0/O/+UP7cbY
         c24tZ9l+JCH/OAoq6L4GGlpy1eIwP49PhdQZLMbtiWAsQYr/HG91Z4DhJpOkGlgl0lxd
         d8Eyhd+4KGr3lSQpfboAfmd1CSMyvwQoQuFQmSI1RDfETmYw6Lg3G2FxcQSvu9kpK5WX
         Itsjc/6Dk42+E4WEjayVmU7vIVaZCbpDLFsWqTtbqdoZbm3B9XIOfzWnKC8RvGC7xO9Z
         Hqgkff6NUrwdMtaoTnFW05bm50QjqpTWXHI06L7b0NEaQ3t8VuQO30L/frU9LjO/Oi/G
         OTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nuvv3ncQRErLqyNpebLTotEX3oMRdLlj8QPJ8M5lSY4=;
        b=NbOMTH8vGocn4AWNc1w1Oy5MmzKVv87ME0y4P2ZLuSH+w+51Nu1NdcmFOXHx8ug8Kk
         Rwn23IHmbIWrZwTlAY62qLQZDpNPacvjMAdWOo+iKERuXDuMM7CmYe5Y/MFZRJjBcc9N
         k2nfqBuPs9TqcALKfpfC4mZk1ZubeJUg8HhI3AfRWWMCV5O0cKp91F/uyJHjN6p9uMOR
         LjRkHZ+4DOzxFl42X6amOkWF5MpHlxSmvuiXxLrXP1GTlXKQGDFG71pQ1lGHu4GNc4jV
         JL8ybsFVh37s6WgvEk28/dHsFNYSMMkoI4UdQiQ/6NlWmQo2F1cEDyHehBDshL/Jk8tN
         QFlQ==
X-Gm-Message-State: APjAAAWJ5ZBneGnQz0vq27mkth8281BzgpkKnuLqI4DwnONaSioS3CrW
	NDoTBZduB9bRhBq7VsFO3lntdXYx+xw=
X-Google-Smtp-Source: APXvYqzgIVzFVHhk27g8y/R521EnVT7MUZZTyDlVHP56DRA4ayE6VJWsSZaLPEg7+rlSc0WdlXvH8w==
X-Received: by 2002:a63:f643:: with SMTP id u3mr1497085pgj.291.1575610530131;
        Thu, 05 Dec 2019 21:35:30 -0800 (PST)
Received: from santosiv.in.ibm.com ([129.41.84.79])
        by smtp.gmail.com with ESMTPSA id n12sm12808371pgb.32.2019.12.05.21.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 21:35:29 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: linux-nvdimm@lists.01.org,
	Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl V2] namespace/create: Don't create multiple namespaces unless greedy
Date: Fri,  6 Dec 2019 11:05:20 +0530
Message-Id: <20191206053520.235805-1-santosh@fossix.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Message-ID-Hash: MSKQKW5D6JMXOAZFUPDBUQ5EZ6HNAX4F
X-Message-ID-Hash: MSKQKW5D6JMXOAZFUPDBUQ5EZ6HNAX4F
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Vaibhav Jain <vaibhav@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MSKQKW5D6JMXOAZFUPDBUQ5EZ6HNAX4F/>
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

The force flag makes sense only in the case of a reconfiguration or
greedy namespace creation.

Fixes: c75f7236d (ndctl/namespace: add a --continue option to create namespaces greedily)
Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 ndctl/namespace.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index 7fb0007..b1f2158 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -1388,11 +1388,9 @@ static int do_xaction_namespace(const char *namespace,
 					(*processed)++;
 					if (param.greedy)
 						continue;
-				}
-				if (force) {
-					if (rc)
+				} else if (param.greedy && force) {
 						saved_rc = rc;
-					continue;
+						continue;
 				}
 				return rc;
 			}
-- 
2.23.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
