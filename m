Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 926DF5845C
	for <lists+linux-nvdimm@lfdr.de>; Thu, 27 Jun 2019 16:20:06 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E9E5B212AAB7B;
	Thu, 27 Jun 2019 07:20:03 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=heysid@ajou.ac.kr; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B0C832129EBB4
 for <linux-nvdimm@lists.01.org>; Thu, 27 Jun 2019 07:19:59 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x15so1327839pfq.0
 for <linux-nvdimm@lists.01.org>; Thu, 27 Jun 2019 07:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ajou.ac.kr; s=google;
 h=date:from:to:cc:subject:message-id:reply-to:mime-version
 :content-disposition:user-agent;
 bh=DS3za/krG7KxyBJ+vG2zjVXj6XDJlFSRs9NVZVEF+Jc=;
 b=r9B3so9KeqHB31L9rVmF4vuh18nVz3VoLtGF08ErOmCDRGNAisbfK3wENgybKkopPg
 c8oOZmEaO1Zy+/ZKUFoYmss7HowrERdHcuiqHe/4Xss220BKXSUJvyUD5zHckVfCGY4j
 FoXKO164k1eaRbf0mW50PwafBp49lmCQ9wnr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :mime-version:content-disposition:user-agent;
 bh=DS3za/krG7KxyBJ+vG2zjVXj6XDJlFSRs9NVZVEF+Jc=;
 b=qVqH51oJOUOWUN0fAXQfA2T5NS5HILscfgwFwbAPglGVExCUjUzmZ7+5LIyts4QtHx
 pm3Kees/bYUd1z3OuQHVMT0HSjAAvVIQo/W0qa0JFRNuqNTMpWhpRe6w+ZmUkBrb/3ol
 df7X/T7cM1OjOF+GAK1a/GVVRi1YoB6hSitfhsTw7qz+pQexXFyhSFWXa2+meez5ovk2
 23UsyF/TsidpoVDLtK4V0tdcecsNBvDytbhx83VEwvQPX4dCs1d8jlnkHykCy07bLuza
 u/8lUWg7fmjyL6MUcb/f2b7g0U3EHRYog0P6b519ycbtBjYLr1NFp9XkVbiSB0spmgRA
 6bRw==
X-Gm-Message-State: APjAAAWeM4sp735QN2MD79SnY8TIS7lNdchCNGsTuhm536bij2aohINm
 Fwmcax8PuQmFLp2CeFDvXJ5Ogg==
X-Google-Smtp-Source: APXvYqzZh58WAjM35iRVq/24lIXhmNrAYGmKbsGJYRTSPL4KhwnLGeVRaC4wKkhs4jOiYbTEdl5s9Q==
X-Received: by 2002:a17:90a:9201:: with SMTP id
 m1mr6470756pjo.38.1561645199447; 
 Thu, 27 Jun 2019 07:19:59 -0700 (PDT)
Received: from swarm07 ([210.107.197.31])
 by smtp.gmail.com with ESMTPSA id bo20sm5056527pjb.23.2019.06.27.07.19.57
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 27 Jun 2019 07:19:58 -0700 (PDT)
Date: Thu, 27 Jun 2019 14:19:53 +0000
From: Won-Kyo Choe <heysid@ajou.ac.kr>
To: dave.hansen@intel.com
Subject: A write error on converting dax0.0 to kmem
Message-ID: <20190627141953.GC3624@swarm07>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Reply-To: heysid@ajou.ac.kr
Cc: linux-mm@kvack.org, jsahn@ajou.ac.kr, linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Hi, Dave. I hope this message is sent appropriately in this time.

We've recently got a new machine which contains Optane DC memory and 
tried to use your patch set[1] in a recent kernel version(5.1.15). 
Unfortunately, we've failed on the last step[2] that describes 
converting device-dax driver as kmem. The main error is "echo: write error: No such device". 
We are certain that there must be a device and it should be recognized 
since we can see it in a path "/dev/dax0.0", however, somehow it keeps saying that error.

We've followed all your steps in the first patch[1] except a step about qemu configuration 
since we already have a persistent memory. We even checked that there is a region 
mapped with persistent memory from a command, `dmesg | grep e820` described in below.

BIOS-e820: [mem 0x0000000880000000-0x00000027ffffffff] persistent (type 7)

As the address is shown above, the thing is that in the qemu, the region is set as 
persistent (type 12) but in the native machine, it says persistent (type 7). 
We've still tried to find what type means and we simply guess that this is one 
of the reasons why we are not able to set the device as kmem.

We'd like to know why this error comes up and how can we handle this problem. 
We would really appreciate it if you are able to little bit help us.

Regards,

Won-Kyo

1. https://patchwork.kernel.org/cover/10829019/
2. https://patchwork.kernel.org/patch/10829041/

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
