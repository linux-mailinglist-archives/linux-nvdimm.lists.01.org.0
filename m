Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA2C307E5
	for <lists+linux-nvdimm@lfdr.de>; Fri, 31 May 2019 06:55:50 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 99DCF2128D6A1;
	Thu, 30 May 2019 21:55:48 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::141; helo=mail-it1-x141.google.com;
 envelope-from=dan.j.williams@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-it1-x141.google.com (mail-it1-x141.google.com
 [IPv6:2607:f8b0:4864:20::141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 2DF5621281EE6
 for <linux-nvdimm@lists.01.org>; Thu, 30 May 2019 21:55:46 -0700 (PDT)
Received: by mail-it1-x141.google.com with SMTP id j17so9945077itk.0
 for <linux-nvdimm@lists.01.org>; Thu, 30 May 2019 21:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SrA62yvlpzIusJ4Q/zDn16kXQwc38lWt69NTafugZzU=;
 b=CWicExeAWqE2BkBpr8x5Lhj3ArD934+YZFkJ12kOL6EdY5CdIECATiI48dc6JGtp79
 mIgtvi1GJQ4QUa2rJliXFWEaLH/d/NJS/8hm0lv7qp57/G2oUE0eH+Jw5aaJSwjEHXy9
 j8DNBDdzN5i55N8KgqHoibhE8ZJHvaXPJ+TgQ3R5WdTEh8HpHxp6Dccj6JCat0Nhugbv
 uXvtVMJlhKNFP9lzTUxNqmy8CIjRMOYxnygXsHxoHbYbmLleHv36cH9IMgz+8UrS0Ukk
 K4WJs/zs4lyGoL6Pi2PTnbqDNOVdVoYnvLx3XTogIJEGUf0sWR+0zpjzY8xgGAIR+6Dc
 5mxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SrA62yvlpzIusJ4Q/zDn16kXQwc38lWt69NTafugZzU=;
 b=rL9T8HQesA46w1YE0GQNGak72snb2HB1TnvhTieDrXoe8YsUf3z10jloApEDfG0pYG
 UHRi2ZsfVqgu/JROlbbui717AhTooW7d/c31/cAQD1JkC+JitJAyP+3NYu0G4iDX3BeV
 aHpE5i9y3dt+uOp0b/tlqHKtS4CVa0ZlFp3FX1XMXccdB0ymPhGAHPEc9uGt4xMCkAsa
 AXFmtbh2DRry9bASOvx1x5l7aDm7Kxmt/MlroG6t8WCiAAxu1rW9VCMM+YJpi4cSW1Yq
 pQnH3su1fCzc7p+VK7R386NIS1uJXkE+oMyKEwjet8ExUVvPGpVIRVXAXxXgqQJyHyJg
 OVpQ==
X-Gm-Message-State: APjAAAVpjGSJxA2CrGrTVX1OpAezyPI1gGaLlIuJ4Ezfuc3XTa7aZuQK
 EsZyJ4Mdawq4G+mJQe5XhARVqXivi2pgOD/pX8c=
X-Google-Smtp-Source: APXvYqzEyOz2EzW5GCbsj3MdsgN8Odl9eCYxFzIXiofkKuhVnOfszV55LiWaJtytTDIl5GA4OdiB5vN32wpRtRMIVMI=
X-Received: by 2002:a02:5143:: with SMTP id s64mr5343622jaa.54.1559278545496; 
 Thu, 30 May 2019 21:55:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190508061726.27631-1-tao3.xu@intel.com>
In-Reply-To: <20190508061726.27631-1-tao3.xu@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 30 May 2019 21:55:34 -0700
Message-ID: <CAA9_cmefLY4ktBf4fOXPUbMGX7faiVDV+bKeUhgkUH2+yn7JuQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v4 00/11] Build ACPI Heterogeneous Memory
 Attribute Table (HMAT)
To: Tao Xu <tao3.xu@intel.com>
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
Cc: xiaoguangrong.eric@gmail.com, "Michael S. Tsirkin" <mst@redhat.com>,
 jingqi.liu@intel.com, linux-nvdimm <linux-nvdimm@lists.01.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, rth@twiddle.net, eblake@redhat.com,
 ehabkost@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, May 7, 2019 at 11:32 PM Tao Xu <tao3.xu@intel.com> wrote:
>
> This series of patches will build Heterogeneous Memory Attribute Table (HMAT)
> according to the command line. The ACPI HMAT describes the memory attributes,
> such as memory side cache attributes and bandwidth and latency details,
> related to the System Physical Address (SPA) Memory Ranges.
> The software is expected to use this information as hint for optimization.
>
> OSPM evaluates HMAT only during system initialization. Any changes to the HMAT
> state at runtime or information regarding HMAT for hot plug are communicated
> using the _HMA method.
[..]

Hi,

I gave these patches a try while developing support for the new EFI
v2.8 Specific Purpose Memory attribute [1]. I have a gap / feature
request to note to make this implementation capable of emulating
current shipping platform BIOS implementations for persistent memory
platforms.

The NUMA configuration I tested was:

        -numa node,mem=4G,cpus=0-19,nodeid=0
        -numa node,mem=4G,cpus=20-39,nodeid=1
        -numa node,mem=4G,nodeid=2
        -numa node,mem=4G,nodeid=3

...and it produced an entry like the following for proximity domain 2.

[0C8h 0200   2]               Structure Type : 0000 [Memory Proximity
Domain Attributes]
[0CAh 0202   2]                     Reserved : 0000
[0CCh 0204   4]                       Length : 00000028
[0D0h 0208   2]        Flags (decoded below) : 0002
            Processor Proximity Domain Valid : 0
[0D2h 0210   2]                    Reserved1 : 0000
[0D4h 0212   4]   Processor Proximity Domain : 00000002
[0D8h 0216   4]      Memory Proximity Domain : 00000002
[0DCh 0220   4]                    Reserved2 : 00000000
[0E0h 0224   8]                    Reserved3 : 0000000240000000
[0E8h 0232   8]                    Reserved4 : 0000000100000000

Notice that the Processor "Proximity Domain Valid" bit is clear. I
understand that the implementation is keying off of whether cpus are
defined for that same node or not, but that's not how current
persistent memory platforms implement "Processor Proximity Domain". On
these platforms persistent memory indeed has its own proximity domain,
but the Processor Proximity Domain is expected to be assigned to the
domain that houses the memory controller for that persistent memory.
So to emulate that configuration it would be useful to have a way to
specify "Processor Proximity Domain" without needing to define CPUs in
that domain.

Something like:

        -numa node,mem=4G,cpus=0-19,nodeid=0
        -numa node,mem=4G,cpus=20-39,nodeid=1
        -numa node,mem=4G,nodeid=2,localnodeid=0
        -numa node,mem=4G,nodeid=3,localnodeid=1

...to specify that node2 memory is connected / local to node0 and
node3 memory is connected / local to node1. In general HMAT specifies
that all performance differentiated memory ranges have their own
proximity domain, but those are expected to still be associated with a
local/host/home-socket memory controller.

[1]: https://lists.01.org/pipermail/linux-nvdimm/2019-May/021668.html
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
