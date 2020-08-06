Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AC123DAC8
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 Aug 2020 15:35:02 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BC6CA10FCBC35;
	Thu,  6 Aug 2020 06:35:00 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com; envelope-from=mingo.kernel.org@gmail.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1980510FC3BC5;
	Thu,  6 Aug 2020 06:34:58 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id m22so7238100eje.10;
        Thu, 06 Aug 2020 06:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rHqK38RuQ1sMAtSHsZ2jsHuSBhnKgRChw9PQXC5x/g8=;
        b=sHWsqQ3TaSk6xJtrxM7Zc2Si/hyLogx7R6vH44UqXNDLOarqWO/Vwyj5oMFdsWhsrq
         vXDe+POevMDU6Qf182IB0fgloTCU8P58rQAb/o3VmZS8mt7vs97r4K/faIC4dqGN4S/I
         uA0IpIurwug134o9qyzqFXZxk4EtAOAojb9Gp7cU3iNfBPhaSAZNSquAnQclz3EdEzNQ
         4gWTte+o0J7cVAlT9UNY3fdAKLHzw6XP0FNAS3cT05jhD+aK/24wmYZfVsn/HHX7qYjc
         ZRNJZCokPsmV/7mTUxcySkX9qKCivK9hIKO4kxK4iGGHNun7KSL9ySXvV4MSchWCd27O
         nhnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=rHqK38RuQ1sMAtSHsZ2jsHuSBhnKgRChw9PQXC5x/g8=;
        b=eMR3eyOBqLHzbrGzOe1HRbBreFx0YTORJ0fJGiM+c8i1bk6ZsxIStly4ODfbmn718Q
         xGfS61di/ElfluNMK6qUOMF73WIS5H7f+zIuZt4+LodQBiEmm1NPt/5VuzbVI9C7iN6F
         fdFyqABo4g9YPYn60eWG28fg2YhSMgie5H26VISkl/TViZhKvDh4EVxMmk1mhN+soadL
         qhf2m3DgEg8723j0Sd43OfAn8POgASQRzUcDwnl6IANXs8vJ/mmghUHIlm5B46Pt9Xz3
         /OLIL6hK9yszJCWvGcUVi+uxFBNTVzlws/xONuE5cMAQFyXRpyHvu0vR23xSkBNv00va
         Af0w==
X-Gm-Message-State: AOAM5335bvjJvLaN/S4qZEf+NWUNET3SLhXrZQd+aHHKvKf2dd8KYfUz
	KVZMxpx3Mcb2iaM6JkF+w+M=
X-Google-Smtp-Source: ABdhPJxA45bEMOJ9OTb4XWQbJNSFMMrPISkudFSUfT5Q7ezhysd1aO9TdtNGzvcZBPBZPfEKv3sVkg==
X-Received: by 2002:a17:906:a201:: with SMTP id r1mr4317065ejy.432.1596720896099;
        Thu, 06 Aug 2020 06:34:56 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id x1sm3665602ejc.119.2020.08.06.06.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 06:34:54 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 6 Aug 2020 15:34:52 +0200
From: Ingo Molnar <mingo@kernel.org>
To: kernel test robot <rong.a.chen@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [x86/copy_mc] a0ac629ebe: fio.read_iops -43.3% regression
Message-ID: <20200806133452.GA2077191@gmail.com>
References: <159630256804.3143511.8894023468833792004.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200803094257.GA23458@shao2-debian>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200803094257.GA23458@shao2-debian>
Message-ID-Hash: U3UW3OIKBU2NMCWRA3Z35SVDM2GA34GN
X-Message-ID-Hash: U3UW3OIKBU2NMCWRA3Z35SVDM2GA34GN
X-MailFrom: mingo.kernel.org@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, stable@vger.kernel.org, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Tony Luck <tony.luck@intel.com>, Erwin Tsaur <erwin.tsaur@intel.com>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, 0day robot <lkp@intel.com>, lkp@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/U3UW3OIKBU2NMCWRA3Z35SVDM2GA34GN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


* kernel test robot <rong.a.chen@intel.com> wrote:

> Greeting,
> 
> FYI, we noticed a -43.3% regression of fio.read_iops due to commit:
> 
> 
> commit: a0ac629ebe7b3d248cb93807782a00d9142fdb98 ("x86/copy_mc: Introduce copy_mc_generic()")
> url: https://github.com/0day-ci/linux/commits/Dan-Williams/Renovate-memcpy_mcsafe-with-copy_mc_to_-user-kernel/20200802-014046
> 
> 
> in testcase: fio-basic
> on test machine: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 256G memory
> with following parameters:

So this performance regression, if it isn't a spurious result, looks 
concerning. Is this expected?

Thanks,

	Ingo
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
