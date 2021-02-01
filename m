Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EFC30B34F
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Feb 2021 00:19:46 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 099A2100EB340;
	Mon,  1 Feb 2021 15:19:45 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 56D7C100EB33D
	for <linux-nvdimm@lists.01.org>; Mon,  1 Feb 2021 15:19:42 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id z22so20855803edb.9
        for <linux-nvdimm@lists.01.org>; Mon, 01 Feb 2021 15:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yEGz+dLPiI3e/jslfpMf9TOttSm5sVcrBxCPC90Kx7M=;
        b=MZN+I2UZ85k4O9bkOQ+ITr8FDAC79nO7UygEAdCz8z21VIPTEUWijheuNedhuaEq//
         U0lspKWMTYEyOqzLTh7y0dph80lY3mvfrvBxSZjhAtzoE0mCqNA1MA/4IfqLkhKLra71
         00zpbAzkzwjddfrjL38YMX/OO2mDfIBbUyprulTaDTBubemXOC1lNmtK4LbjzFUHurc6
         TPiI9ZkW8IGmQ/GXLLrHZ/+9HskyuHXEGYfINQBJM7iWaPoN+ron/s/iKUQcDDohf+dM
         3DFTnfiaFeNQiGN1oMIc69tB+N16+0Dt52gzAUJfHaRCa9uHDsljZAkjBEsSxnAwpD7R
         Y72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yEGz+dLPiI3e/jslfpMf9TOttSm5sVcrBxCPC90Kx7M=;
        b=AhIegI6EB+vsKTDQEpgjlTwc1/eWGicOqBTfvGN6+wRXzS2RKUMRkHO2GGpKrdazPu
         XejngZiqXK+VQaVPZ7vm5FcoJcrfG01LOLUwTgi8Y9oMEpMOXSly8pHN/wJMjaYITRIU
         U1yK+V7FDDkRiPxWZh8sdG0TEK0GPfbaa2CBKGRAiDC2/dn+8R/MIqNi4fY56X5C13vc
         b+++x9lu/3ReRj2sjPbHaswQ3s1uXI+BKSn/BDgPO8akYAc1kArv5dbCI1p99sSAFJ0q
         RrNw0bwc4yEfFvRDfdLZXRKyxAC9goXGs6DQI6/ZzPLJyS+5eJmOWrRs1JhJZuvGjYuv
         djwg==
X-Gm-Message-State: AOAM533H+08OSmklNh0XCSDXwMIWeZTsXAC08mR7vITwa0m0ePDBbOWQ
	S2JKoY4EJ7DrG7JFM/GT0EfsNJ2Giw/xkH6z4wBxUw==
X-Google-Smtp-Source: ABdhPJwoXp33gfzuIBwe2JXmvKCytBg+xKcBWV6c56gwpEwjaF9fYaIdATFU4OOlSxGwozZCpPiy8HRA2T7eVRgj2Kk=
X-Received: by 2002:a50:f19a:: with SMTP id x26mr12051589edl.354.1612221580105;
 Mon, 01 Feb 2021 15:19:40 -0800 (PST)
MIME-Version: 1.0
References: <20200615074723.12163-1-rpalethorpe@suse.com>
In-Reply-To: <20200615074723.12163-1-rpalethorpe@suse.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 1 Feb 2021 15:19:37 -0800
Message-ID: <CAPcyv4jzfnnOTJTK5WKYpt_qOm1UWv-PZ7ZH3GiXf7x_oz6jQw@mail.gmail.com>
Subject: Re: [PATCH v2] nvdimm: Avoid race between probe and reading device attributes
To: Richard Palethorpe <rpalethorpe@suse.com>
Message-ID-Hash: LQMDVUAQ2ASA4ZH4V67J65WPP5KVUMFO
X-Message-ID-Hash: LQMDVUAQ2ASA4ZH4V67J65WPP5KVUMFO
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Coly Li <colyli@suse.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LQMDVUAQ2ASA4ZH4V67J65WPP5KVUMFO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Yikes, sorry this languished so long, comments below:

On Mon, Jun 15, 2020 at 12:48 AM Richard Palethorpe
<rpalethorpe@suse.com> wrote:
>
> It is possible to cause a division error and use-after-free by querying the
> nmem device before the driver data is fully initialised in nvdimm_probe. E.g
> by doing
>
> (while true; do
>      cat /sys/bus/nd/devices/nmem*/available_slots 2>&1 > /dev/null
>  done) &
>
> while true; do
>      for i in $(seq 0 4); do
>          echo nmem$i > /sys/bus/nd/drivers/nvdimm/bind
>      done
>      for i in $(seq 0 4); do
>          echo nmem$i > /sys/bus/nd/drivers/nvdimm/unbind
>      done
>  done
>
> On 5.7-rc3 this causes:
>
> [   12.711578] divide error: 0000 [#1] SMP KASAN PTI
> [   12.714857] RIP: 0010:nd_label_nfree+0x134/0x1a0 [libnvdimm]
[..]
> [   12.725308] CR2: 00007fd16f1ec000 CR3: 0000000064322006 CR4: 0000000000160ef0
> [   12.726268] Call Trace:
> [   12.726633]  available_slots_show+0x4e/0x120 [libnvdimm]
> [   12.727380]  dev_attr_show+0x42/0x80
> [   12.727891]  ? memset+0x20/0x40
> [   12.728341]  sysfs_kf_seq_show+0x218/0x410
> [   12.728923]  seq_read+0x389/0xe10
> [   12.729415]  vfs_read+0x101/0x2d0
> [   12.729891]  ksys_read+0xf9/0x1d0
> [   12.730361]  ? kernel_write+0x120/0x120
> [   12.730915]  do_syscall_64+0x95/0x4a0
> [   12.731435]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
[..]
> Fixes: 4d88a97aa9e8 ("libnvdimm, nvdimm: dimm driver and base libnvdimm device-driver infrastructure")
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: linux-nvdimm@lists.01.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Coly Li <colyli@suse.com>
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
>
> V2:
> + Reviewed by Coly and removed unecessary lock
>
>  drivers/nvdimm/dimm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvdimm/dimm.c b/drivers/nvdimm/dimm.c
> index 7d4ddc4d9322..3d3988e1d9a0 100644
> --- a/drivers/nvdimm/dimm.c
> +++ b/drivers/nvdimm/dimm.c
> @@ -43,7 +43,6 @@ static int nvdimm_probe(struct device *dev)
>         if (!ndd)
>                 return -ENOMEM;
>
> -       dev_set_drvdata(dev, ndd);
>         ndd->dpa.name = dev_name(dev);
>         ndd->ns_current = -1;
>         ndd->ns_next = -1;
> @@ -106,6 +105,8 @@ static int nvdimm_probe(struct device *dev)
>         if (rc)
>                 goto err;
>
> +       dev_set_drvdata(dev, ndd);
> +

I see why this works, but I think the bug is in
available_slots_show(). It is a bug for a sysfs attribute to reference
driver-data without synchronizing against bind. So it should be
possible for probe set that pointer whenever it wants. In other words
this fix (forgive the whitespace damage from pasting).

diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index b59032e0859b..e68b17bc7aab 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -335,10 +335,8 @@ static ssize_t state_show(struct device *dev,
struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(state);

-static ssize_t available_slots_show(struct device *dev,
-               struct device_attribute *attr, char *buf)
+static ssize_t __available_slots_show(struct nvdimm_drvdata *ndd, char *buf)
 {
-       struct nvdimm_drvdata *ndd = dev_get_drvdata(dev);
        ssize_t rc;
        u32 nfree;

@@ -356,6 +354,18 @@ static ssize_t available_slots_show(struct device *dev,
        nvdimm_bus_unlock(dev);
        return rc;
 }
+
+static ssize_t available_slots_show(struct device *dev,
+                                   struct device_attribute *attr, char *buf)
+{
+       ssize_t rc;
+
+       nd_device_lock(dev);
+       rc = __available_slots_show(dev_get_drvdata(dev), buf);
+       nd_device_unlock(dev);
+
+       return rc;
+}
 static DEVICE_ATTR_RO(available_slots);

 __weak ssize_t security_show(struct device *dev,
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
