Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CBA8DB1B
	for <lists+linux-nvdimm@lfdr.de>; Wed, 14 Aug 2019 19:23:06 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2F5452030431D;
	Wed, 14 Aug 2019 10:25:08 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=sboyd@kernel.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 41825203042F4
 for <linux-nvdimm@lists.01.org>; Wed, 14 Aug 2019 10:25:06 -0700 (PDT)
Received: from kernel.org (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9246520665;
 Wed, 14 Aug 2019 17:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1565803381;
 bh=FN7svZ/+iXMULArgYt1oBNGNoJcD+bkl47j+nxOdq5Y=;
 h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
 b=U2k+Omw28LwRRoFmVtodT07PV6nxV/NjO0n84ZnQwJqJzPx0vkjnq79bp1wEvklFG
 VMEVAJLqqexfV8yMpJeyrQSBTfCgZag1WzGsv1E4V8fP+esmsvW+CqJy/MmWeHrA/1
 KqbEgb8F4a9wCCJHNpBFKV7UIh0krHKOR86fwJ8w=
MIME-Version: 1.0
In-Reply-To: <CAFd5g45NdQEcP0JQpZc3HYYgNZfsBsHL+ByXRK+OupWObwMuqg@mail.gmail.com>
References: <20190814055108.214253-1-brendanhiggins@google.com>
 <CAFd5g45NdQEcP0JQpZc3HYYgNZfsBsHL+ByXRK+OupWObwMuqg@mail.gmail.com>
Subject: Re: [PATCH v13 00/18] kunit: introduce KUnit,
 the Linux kernel unit testing framework
From: Stephen Boyd <sboyd@kernel.org>
To: Brendan Higgins <brendanhiggins@google.com>,
 Frank Rowand <frowand.list@gmail.com>, Greg KH <gregkh@linuxfoundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Kees Cook <keescook@google.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, shuah <shuah@kernel.org>
User-Agent: alot/0.8.1
Date: Wed, 14 Aug 2019 10:23:00 -0700
Message-Id: <20190814172301.9246520665@mail.kernel.org>
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
Cc: , Petr Mladek <pmladek@suse.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Sasha Levin <Alexander.Levin@microsoft.com>, at@ml01.01.org,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	linux-nvdimm <linux-nvdimm@lists.01.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Knut Omang <knut.omang@oracle.com>, wfg@linux.intel.com,
	Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>,
	Jeff Dike <jdike@addtoit.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	devicetree <devicetree@vger.kernel.org>,
	linux-kbuild <linux-kbuild@vger.kernel.org>,
	"Bird,  Timothy" <Tim.Bird@sony.com>, linux-um@lists.infradead.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Bjorn Helgaas <bhelgaas@google.com>, kunit-dev@googlegroups.com,
	Richard Weinberger <richard@nod>,
	Randy Dunlap <rdunlap@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	Michael Ellerman <mpe@ellerman.id.au>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Quoting Brendan Higgins (2019-08-14 03:03:47)
> On Tue, Aug 13, 2019 at 10:52 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > ## TL;DR
> >
> > This revision addresses comments from Stephen and Bjorn Helgaas. Most
> > changes are pretty minor stuff that doesn't affect the API in anyway.
> > One significant change, however, is that I added support for freeing
> > kunit_resource managed resources before the test case is finished via
> > kunit_resource_destroy(). Additionally, Bjorn pointed out that I broke
> > KUnit on certain configurations (like the default one for x86, whoops).
> >
> > Based on Stephen's feedback on the previous change, I think we are
> > pretty close. I am not expecting any significant changes from here on
> > out.
> 
> Stephen, it looks like you have just replied with "Reviewed-bys" on
> all the remaining emails that you looked at. Is there anything else
> that we are missing? Or is this ready for Shuah to apply?
> 

I think it's good to go! Thanks for the persistence.

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
