Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDF51E60A
	for <lists+linux-nvdimm@lfdr.de>; Wed, 15 May 2019 02:26:54 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E5914212777A9;
	Tue, 14 May 2019 17:26:52 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=frowand.list@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 60A43212777A5
 for <linux-nvdimm@lists.01.org>; Tue, 14 May 2019 17:26:51 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id j26so391382pgl.5
 for <linux-nvdimm@lists.01.org>; Tue, 14 May 2019 17:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=ypDVsaFFOykr6yuKVx2k2XaJyOr+u5tERYjVpiOjyiw=;
 b=IuVZ2l4O+MIDyXpYgUM5qQQYoX7Y/sJsvGPvmvehKAC4lwwIGDudhzngFBjnRWN5ci
 k8JCzwMxo0FPATgnUf4u2R2YAGB3ucoMe6dvaUUgS8cW7nlEYr0d+QFwmikIyWdOae9X
 BS5/vwSRCViiC8xY3hAHYh4bpV2zhvnq0blTNTPWsFb+XmhdfxM+Bo2jZReJurV/GrST
 8fIBxa0ZCqTTyE7l8H4cMfsveUZmMSCHTxDv7jz/q6pmMaZ1VAUfFLnS/1mPPZOC7zye
 iSrgkJ/pxklMI6fKQALs4Yf/9f1VNfTv8Na0CM/+Hu116UCn5U7KYQb+xYIHEY5zeGUw
 h+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ypDVsaFFOykr6yuKVx2k2XaJyOr+u5tERYjVpiOjyiw=;
 b=S6o9Q9YiipprkzGebY8QD9qD5lNr66xu9rTlUyOYbTnH5R9Wx6FFRpFsh0YBPjH/su
 KkntRMy5Vi55IxsSwJ4zBViRYGzdo2ztP7WdUj5FJAUqkRHw+sR8pM/Zr1pfJnWUZv0p
 mFJ7Kpc/FclOr+w5do7cPneTCrfRWst10oVNhd35bqDkZZxRgbwM3ScRZTPytrezzr7/
 /1TiNVho/zy0Bzone3z5HQEVmKAuqZACH17l4zhOe/HjS9ozEbcy0EHzcsKEyRRZOnYj
 5wz8d8az29Gi4fS9zxGehrNkvRcZpP7RmPzgfOtGxtKfOoNexHNfV8JK2lt3ZGzMRhnN
 6c1A==
X-Gm-Message-State: APjAAAVHFDlgyUqQltCk2qOYIkHZgllDVLLffvugINEpwT3h3lLJLnnD
 FIBltXxqlsNy/L2pYkkKra8=
X-Google-Smtp-Source: APXvYqzd3JNtsP3FkyXRtoQpQjmSxi6gP+3fyLytxrHZq7D+o9iT6N45YBj70jF10Gduz840x4f9ig==
X-Received: by 2002:a63:1c4:: with SMTP id 187mr13725679pgb.317.1557880010775; 
 Tue, 14 May 2019 17:26:50 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id 204sm272559pgh.50.2019.05.14.17.26.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 14 May 2019 17:26:50 -0700 (PDT)
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To: Theodore Ts'o <tytso@mit.edu>, Tim.Bird@sony.com, knut.omang@oracle.com,
 gregkh@linuxfoundation.org, brendanhiggins@google.com, keescook@google.com,
 kieran.bingham@ideasonboard.com, mcgrof@kernel.org, robh@kernel.org,
 sboyd@kernel.org, shuah@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
 linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
 linux-um@lists.infradead.org, Alexander.Levin@microsoft.com,
 amir73il@gmail.com, dan.carpenter@oracle.com, dan.j.williams@intel.com,
 daniel@ffwll.ch, jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
 khilman@baylibre.com, logang@deltatee.com, mpe@ellerman.id.au,
 pmladek@suse.com, richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
 wfg@linux.intel.com
References: <a09a7e0e-9894-8c1a-34eb-fc482b1759d0@gmail.com>
 <20190509015856.GB7031@mit.edu>
 <580e092f-fa4e-eedc-9e9a-a57dd085f0a6@gmail.com>
 <20190509032017.GA29703@mit.edu>
 <7fd35df81c06f6eb319223a22e7b93f29926edb9.camel@oracle.com>
 <20190509133551.GD29703@mit.edu>
 <ECADFF3FD767C149AD96A924E7EA6EAF9770D591@USCULXMSG01.am.sony.com>
 <875c546d-9713-bb59-47e4-77a1d2c69a6d@gmail.com>
 <20190509214233.GA20877@mit.edu>
 <80c72e64-2665-bd51-f78c-97f50f9a53ba@gmail.com>
 <20190511173344.GA8507@mit.edu>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <a305c732-9953-8724-b4a4-25aa50c89365@gmail.com>
Date: Tue, 14 May 2019 17:26:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190511173344.GA8507@mit.edu>
Content-Language: en-US
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 5/11/19 10:33 AM, Theodore Ts'o wrote:
> On Fri, May 10, 2019 at 02:12:40PM -0700, Frank Rowand wrote:
>> However, the reply is incorrect.  Kselftest in-kernel tests (which
>> is the context here) can be configured as built in instead of as
>> a module, and built in a UML kernel.  The UML kernel can boot,
>> running the in-kernel tests before UML attempts to invoke the
>> init process.
> 
> Um, Citation needed?

The paragraph that you quoted tells you exactly how to run a kselftest
in-kernel test in a UML kernel.  Just to what that paragraph says.


> 
> I don't see any evidence for this in the kselftest documentation, nor
> do I see any evidence of this in the kselftest Makefiles.
> 
> There exists test modules in the kernel that run before the init
> scripts run --- but that's not strictly speaking part of kselftests,
> and do not have any kind of infrastructure.  As noted, the
> kselftests_harness header file fundamentally assumes that you are
> running test code in userspace.

You are ignoring the kselftest in-kernel tests.

We are talking in circles.  I'm done with this thread.

-Frank

> 
> 				- Ted
> .
> 

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
