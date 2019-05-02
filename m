Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACB11249A
	for <lists+linux-nvdimm@lfdr.de>; Fri,  3 May 2019 00:36:17 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2AFFB212449E0;
	Thu,  2 May 2019 15:36:15 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com;
 envelope-from=pasha.tatashin@soleen.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 06F492194EB76
 for <linux-nvdimm@lists.01.org>; Thu,  2 May 2019 15:36:12 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id e56so3724524ede.7
 for <linux-nvdimm@lists.01.org>; Thu, 02 May 2019 15:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wzidWzynEo/DXM93j3mYhduzzCvKaQ+YtgjP83dctao=;
 b=X5ETGGaJfQHGRUSnWQGIOq/DgYJrpmnwNLAnBCGvjMzs0IYe8H4k40vhnG0x0PtTXp
 sWQK2U+FmSPBGJ7GR24/JK9f/hCOJYyze5MUGSel6z7iEB2sqXVMPf6aTn86R4AaP5pn
 6FQEVIGwKuIcdbr4sts+qszeoBo6aIl94MXIXsfPMXP6bKsBgX72s1UofOvqOnoksME5
 Pe6MLS/OzDiGFJY2jo8fG3gHRVo3/NlsmLVP785V1Tu7GO8PNXBXjVIm7U0cXNqw9t+9
 Pj427ef28DFtRCbdaODf41bCvVkT1US/U8Mq5PyhZKAJJ46/wRGm0zL69PqfxQgIYKkB
 BZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wzidWzynEo/DXM93j3mYhduzzCvKaQ+YtgjP83dctao=;
 b=l+bxR7ScNkAgmqLxodAxUb5JKdRXcWlhETvORD3ayvTqBEF7y/ZLNFXkGKM7jRaEGh
 PWgPZJt4vLEw+wawZEF99idYdr8r6T6ZjfOiqjEnLJ2JgXye/7vvKA/Mjk577mo0s3S9
 6oHZq7vJaCODcagP0sqU834VNmDkQCZudVjjtMd/QIAf7tbyGv3yBVVMlBbZ1avdwqsn
 qiLj2hdEE43u52cu1fPiyj3aDeLQhQFnXJmh8Xt3LS2mFk74cqqkLWPjgW8Krcjzi68P
 PaPbg1RBuA2mjLJbQy+52xpe+tN2jNC1qFq7X0fCbwZNKk0boZH2/QyyGyONw3pLY+Zh
 d73w==
X-Gm-Message-State: APjAAAUMq1GXtmYtlh3FFwa3hzXU4jvzGQEvpDJvN5wISUlRRjdaVkAJ
 E1aWI3uZUQy+o1AJuNYyg/J0rV8KVZGJsIYm3cvyOw==
X-Google-Smtp-Source: APXvYqzM3pTNRpb2+kI4mLKyKA2mBJRU32x6x6ySml+fIWvJtXTuJ/Ut8dgCtm/xHIYirHmupbd6Gt2T77m3feSDsdY=
X-Received: by 2002:a17:906:3154:: with SMTP id
 e20mr3210549eje.263.1556836571272; 
 Thu, 02 May 2019 15:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190502184337.20538-1-pasha.tatashin@soleen.com>
 <76dfe7943f2a0ceaca73f5fd23e944dfdc0309d1.camel@intel.com>
 <CA+CK2bA=E4zRFb0Qky=baOQi_LF4x4eu8KVdEkhPJo3wWr8dYQ@mail.gmail.com>
 <9bf70d80718d014601361f07813b68e20b089201.camel@intel.com>
In-Reply-To: <9bf70d80718d014601361f07813b68e20b089201.camel@intel.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 2 May 2019 18:36:00 -0400
Message-ID: <CA+CK2bBRwFN342x3t77CBrFTrXUn3VMn6a-cf-y0fF+2DBYpbA@mail.gmail.com>
Subject: Re: [v5 0/3] "Hotremove" persistent memory
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
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
Cc: "sashal@kernel.org" <sashal@kernel.org>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "mhocko@suse.com" <mhocko@suse.com>, "david@redhat.com" <david@redhat.com>,
 "tiwai@suse.de" <tiwai@suse.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "Huang,
 Ying" <ying.huang@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jmorris@namei.org" <jmorris@namei.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "jglisse@redhat.com" <jglisse@redhat.com>, "Wu,
 Fengguang" <fengguang.wu@intel.com>,
 "baiyaowei@cmss.chinamobile.com" <baiyaowei@cmss.chinamobile.com>,
 "zwisler@kernel.org" <zwisler@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "bp@suse.de" <bp@suse.de>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, May 2, 2019 at 6:29 PM Verma, Vishal L <vishal.l.verma@intel.com> wrote:
>
> On Thu, 2019-05-02 at 17:44 -0400, Pavel Tatashin wrote:
>
> > > In running with these patches, and testing the offlining part, I ran
> > > into the following lockdep below.
> > >
> > > This is with just these three patches on top of -rc7.
> >
> > Hi Verma,
> >
> > Thank you for testing. I wonder if there is a command sequence that I
> > could run to reproduce it?
> > Also, could you please send your config and qemu arguments.
> >
> Yes, here is the qemu config:
>
> qemu-system-x86_64
>         -machine accel=kvm
>         -machine pc-i440fx-2.6,accel=kvm,usb=off,vmport=off,dump-guest-core=off,nvdimm
>         -cpu Haswell-noTSX
>         -m 12G,slots=3,maxmem=44G
>         -realtime mlock=off
>         -smp 8,sockets=2,cores=4,threads=1
>         -numa node,nodeid=0,cpus=0-3,mem=6G
>         -numa node,nodeid=1,cpus=4-7,mem=6G
>         -numa node,nodeid=2
>         -numa node,nodeid=3
>         -drive file=/virt/fedora-test.qcow2,format=qcow2,if=none,id=drive-virtio-disk1
>         -device virtio-blk-pci,scsi=off,bus=pci.0,addr=0x9,drive=drive-virtio-disk1,id=virtio-disk1,bootindex=1
>         -object memory-backend-file,id=mem1,share,mem-path=/virt/nvdimm1,size=16G,align=128M
>         -device nvdimm,memdev=mem1,id=nv1,label-size=2M,node=2
>         -object memory-backend-file,id=mem2,share,mem-path=/virt/nvdimm2,size=16G,align=128M
>         -device nvdimm,memdev=mem2,id=nv2,label-size=2M,node=3
>         -serial stdio
>         -display none
>
> For the command list - I'm using WIP patches to ndctl/daxctl to add the
> command I mentioned earlier. Using this command, I can reproduce the
> lockdep issue. I thought I should be able to reproduce the issue by
> onlining/offlining through sysfs directly too - something like:
>
>    node="$(cat /sys/bus/dax/devices/dax0.0/target_node)"
>    for mem in /sys/devices/system/node/node"$node"/memory*; do
>      echo "offline" > $mem/state
>    done
>
> But with that I can't reproduce the problem.
>
> I'll try to dig a bit deeper into what might be happening, the daxctl
> modifications simply amount to doing the same thing as above in C, so
> I'm not immediately sure what might be happening.
>
> If you're interested, I can post the ndctl patches - maybe as an RFC -
> to test with.

I could apply the patches and test with them. Also, could you please
send your kernel config.

Thank you,
Pasha

>
> Thanks,
> -Vishal
>
>
>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
