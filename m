Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 402186C46D
	for <lists+linux-nvdimm@lfdr.de>; Thu, 18 Jul 2019 03:44:23 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CB124212C01EB;
	Wed, 17 Jul 2019 18:46:49 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 19E5B212C01E4
 for <linux-nvdimm@lists.01.org>; Wed, 17 Jul 2019 18:46:47 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id t76so20216096oih.4
 for <linux-nvdimm@lists.01.org>; Wed, 17 Jul 2019 18:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5py66yaGGH6o0S/awKZtwXrh4ZY1+RpaUyIuZz29wzM=;
 b=spOFMKrdhH3Z47EmIojoI29YhELkzEVT5JhVwiUIqdjnbhNFw4jPZmnzwCKbS1IQLX
 ZseUzxfcTomxaCFGNUe/gwyCfvwSijc6raiWld9JoyOl+RD/j6eJe4MGGTpoUG8rJ2PP
 ukE6Bp0MH6EeMPYttALpHJg1qnFrAZPYIW94MW1+tPKkkam5oASlcat2QKDcDK8C2cMn
 jDDe8/4ZM3eVOiJKDKQelxusjFYucCYVx505qWq/M1lBHp+QD7gjiBec3VBNiKErYu43
 0OmxqxGZV5aqI2WHn9Nwd+ULnHqebQz1gED7GGDBNARKNFpTaDiiFuYwQZWtYmiUEyk0
 VJ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5py66yaGGH6o0S/awKZtwXrh4ZY1+RpaUyIuZz29wzM=;
 b=P1wRXLQx23r13avP4TvpYj8tAWfZ9qVBU0piwBKIKAt3wgAScLLATdPExqlVrgaM4D
 7OiSmlDCDN7tCQSCpswp62UaN7SD5ZdOtibfFQJEGc9egcAWkbnr8WiSXxj/82CX5h11
 nVxrGXx3KgQNEBun3QSVikPQD1icJc5jjpEVknYces8SKSbFJTxoI3PXKoOgwUgojuky
 pBgWQcPqXUCZRkcvrBRBLpaHdZY2GZaT+0v1/3VFqbKEGWz0s5IF09DScDypHWk7POWL
 OT+Dz1eCpcsU1/x55XawFcPckp5W+Dm1a5Oqg0xhR2r5k3ZHXOeKcvBo7VUc3ldIxiK0
 q72Q==
X-Gm-Message-State: APjAAAVRTVaZrEhHQFeltTPUpXRlz5x+HpDFRZLmIjjU5wZ48udMo8Sa
 kn7Zr+sF5Hai+JW55OgwoJ0sJgH5iCVs6UcY44qXlQ==
X-Google-Smtp-Source: APXvYqyH1MjEYtPtUWw/kokA+ieFhYOmJhd/5gTxThEGNM3vt2Q2oAF+nOzm6kAXFY2FUjthqzLAcZ/kshDMM5SHoJ8=
X-Received: by 2002:aca:ba02:: with SMTP id k2mr19473467oif.70.1563414258274; 
 Wed, 17 Jul 2019 18:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190717225400.9494-1-vishal.l.verma@intel.com>
 <20190717225400.9494-3-vishal.l.verma@intel.com>
In-Reply-To: <20190717225400.9494-3-vishal.l.verma@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 17 Jul 2019 18:44:07 -0700
Message-ID: <CAPcyv4ha=vK9fJRkwMzGFOnmnSsgo6HE=_yk_f_O9HawkbJ2DA@mail.gmail.com>
Subject: Re: [ndctl PATCH v6 02/13] libdaxctl: add interfaces to
 enable/disable devices
To: Vishal Verma <vishal.l.verma@intel.com>
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
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Pavel Tatashin <pasha.tatashin@soleen.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jul 17, 2019 at 3:54 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> Add new libdaxctl interfaces to disable a device_dax based device, and
> to enable it into the given mode. The modes available are 'devdax',
> and 'system-ram', where devdax is the normal device DAX mode used
> via a character device, and 'system-ram' uses the kernel's 'kmem'
> facility to hotplug the device making it usable as normal memory.
>
> This adds the following new interfaces:
>
>   daxctl_dev_disable;
>   daxctl_dev_enable_devdax;
>   daxctl_dev_enable_ram;
>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
