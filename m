Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8F211ABF
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 May 2019 16:04:34 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D0BF121243BA0;
	Thu,  2 May 2019 07:04:32 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=shuah@kernel.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 450A321237ABD
 for <linux-nvdimm@lists.01.org>; Thu,  2 May 2019 07:04:30 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net
 [24.9.64.241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AB3F1206DF;
 Thu,  2 May 2019 14:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1556805870;
 bh=Wa7agHm7Un4ja3yaCvgGgD1ND3pUZJ7MD4aKZiRFMCM=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=yX5jTSzrUif4ca3k3xa8i9BRvwX2CoEc3LSZADtQzBQU989uyUErZwEyIeGvuAtbz
 UMq4IZzjZwSlSfIlEfCCs4JueRJdLmpmGVu4hBGn/PniD+9zEIFE0G2oc27b7amOah
 TyFD1OvQOYCZcqsTjmi92jjUJmi6G3VQLb2z3k/0=
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To: Greg KH <gregkh@linuxfoundation.org>,
 Brendan Higgins <brendanhiggins@google.com>
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190502105053.GA12416@kroah.com>
From: shuah <shuah@kernel.org>
Message-ID: <76e84d54-6b7e-8cc1-492b-43822fc43ac4@kernel.org>
Date: Thu, 2 May 2019 08:04:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502105053.GA12416@kroah.com>
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
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, amir73il@gmail.com,
 dri-devel@lists.freedesktop.org, Alexander.Levin@microsoft.com,
 mpe@ellerman.id.au, linux-kselftest@vger.kernel.org, frowand.list@gmail.com,
 robh@kernel.org, linux-nvdimm@lists.01.org, khilman@baylibre.com,
 knut.omang@oracle.com, kieran.bingham@ideasonboard.com, wfg@linux.intel.com,
 joel@jms.id.au, rientjes@google.com, jdike@addtoit.com,
 dan.carpenter@oracle.com, devicetree@vger.kernel.org, shuah <shuah@kernel.org>,
 linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org,
 rostedt@goodmis.org, julia.lawall@lip6.fr, kunit-dev@googlegroups.com,
 richard@nod.at, sboyd@kernel.org, linux-kernel@vger.kernel.org,
 mcgrof@kernel.org, daniel@ffwll.ch, keescook@google.com,
 linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 5/2/19 4:50 AM, Greg KH wrote:
> On Wed, May 01, 2019 at 04:01:09PM -0700, Brendan Higgins wrote:
>> ## TLDR
>>
>> I rebased the last patchset on 5.1-rc7 in hopes that we can get this in
>> 5.2.
> 
> That might be rushing it, normally trees are already closed now for
> 5.2-rc1 if 5.1-final comes out this Sunday.
> 
>> Shuah, I think you, Greg KH, and myself talked off thread, and we agreed
>> we would merge through your tree when the time came? Am I remembering
>> correctly?
> 
> No objection from me.
> 

Yes. I can take these through kselftest tree when the time comes.
Agree with Greg that 5.2 might be rushing it. 5.3 would be a good
target.

thanks,
-- Shuah



_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
