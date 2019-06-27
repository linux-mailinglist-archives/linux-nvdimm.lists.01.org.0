Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8E558CF4
	for <lists+linux-nvdimm@lfdr.de>; Thu, 27 Jun 2019 23:22:57 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E6AB521297063;
	Thu, 27 Jun 2019 14:22:55 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 1C31621290DE4
 for <linux-nvdimm@lists.01.org>; Thu, 27 Jun 2019 14:22:53 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id u15so2563377oiv.0
 for <linux-nvdimm@lists.01.org>; Thu, 27 Jun 2019 14:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=x3+/AfxLXuFdTRt+wVJ5N88Fn0d7Jt0QcG3rrM/CFYA=;
 b=JtErswGhYDCrNfECuAxOCOEYWix8XG5/JXokcc4VzGBzvI/VkBg2osv2Vfd1YgD00G
 zE3E2Ho8y5Rhx0feStd4vbr6fQAxsfG4Nv5BPQm7jBEqo8BCOCXIu/4vhxUCDR29BQ+U
 OLa77XjjP0Pm69hLirNXv/ftJEeFm2u11Pr3wkRrdSGxl28uHh1lWjlkhkChxCFSzuQr
 c5dumHc4sU+K0juZy4Sj6VXj/uQ6kLWl33HbWH9Y5TGQ7rw7vksCHAsfCxblpx1AkLnM
 LPlF8cwYtS1Q06JBzBTUzKidcFSmV8BteXYxDnFcoAX+1FYM8DQl8UDccYpstyCu0Q6d
 /OGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=x3+/AfxLXuFdTRt+wVJ5N88Fn0d7Jt0QcG3rrM/CFYA=;
 b=g5E0doXHXhPiUDfP7MEhMciVSoNLTJv7UoYNgKucOBoyrj81y+A9Y4nttpZNHpR2v1
 vuCiILqKqldCKhAHIKgG/xhu+NuYmWvZVi8scsXRD6p1zx5gMQ04tx34jLjJ45XhO9Hr
 moojAkOPXGXGBHO9reNRY16wRrqOQrzQBqxmI/KEI1JyXwiADoGhw/CvTPEil426kxGz
 ni7nuKCh9l3Tw0+E42VPDO4Lehdiy+A1eFs7PektAUV20V3wncwROLCq5kV5IyFYmHKg
 q6LGqRVpNsV0nrL7QIuLkyEx+cNwoYFWf/ZuOmPfO+yAnQuq6oDVqc5sxAzEcqrw186O
 79ew==
X-Gm-Message-State: APjAAAWdYU4UCmCoYR6Z7h6YorfoTTN1KggsYQSF0Dn0CZCtCdcGn4+f
 5Wt5J7QPMoC5YrkqJb0VJ6E5cgENzX9xo1AIhy6dfg==
X-Google-Smtp-Source: APXvYqx7n5SoatNrD/f6URkFx2YC8fws4Ygfo/qo5bOAO4OD2enVvoI0R9bsVc0OVj1JFlqOFkvvecYbXNjpEzBEU1w=
X-Received: by 2002:aca:fc50:: with SMTP id a77mr3511395oii.0.1561670572927;
 Thu, 27 Jun 2019 14:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190627141953.GC3624@swarm07>
In-Reply-To: <20190627141953.GC3624@swarm07>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 27 Jun 2019 14:22:42 -0700
Message-ID: <CAPcyv4h=MoP4GSF8xRULy54K7Rt9g2pnF3Xw0BNPRyYf5fKs0A@mail.gmail.com>
Subject: Re: A write error on converting dax0.0 to kmem
To: heysid@ajou.ac.kr
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
Cc: Dave Hansen <dave.hansen@intel.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>, jsahn@ajou.ac.kr,
 Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

[ this is on-topic for linux-nvdimm, but likely off-topic for
linux-mm. I leave it cc'd for now ]

On Thu, Jun 27, 2019 at 7:20 AM Won-Kyo Choe <heysid@ajou.ac.kr> wrote:
>
> Hi, Dave. I hope this message is sent appropriately in this time.
>
> We've recently got a new machine which contains Optane DC memory and
> tried to use your patch set[1] in a recent kernel version(5.1.15).
> Unfortunately, we've failed on the last step[2] that describes
> converting device-dax driver as kmem. The main error is "echo: write error: No such device".
> We are certain that there must be a device and it should be recognized
> since we can see it in a path "/dev/dax0.0", however, somehow it keeps saying that error.
>
> We've followed all your steps in the first patch[1] except a step about qemu configuration
> since we already have a persistent memory. We even checked that there is a region
> mapped with persistent memory from a command, `dmesg | grep e820` described in below.
>
> BIOS-e820: [mem 0x0000000880000000-0x00000027ffffffff] persistent (type 7)
>
> As the address is shown above, the thing is that in the qemu, the region is set as
> persistent (type 12) but in the native machine, it says persistent (type 7).
> We've still tried to find what type means and we simply guess that this is one
> of the reasons why we are not able to set the device as kmem.
>
> We'd like to know why this error comes up and how can we handle this problem.
> We would really appreciate it if you are able to little bit help us.

Before digging deeper let's first verify that you have switched
device-dax from using "class" devices to using "bus" devices. Yes,
that step is not included in the changelog instructions. Here is a man
page for a tool that can automate some of the steps for you:

http://pmem.io/ndctl/daxctl-migrate-device-model.html

You can validate that you're in "bus" mode by making sure a "dax0.0"
link appears under "/sys/bus/dax/devices".
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
