Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5B6127E1
	for <lists+linux-nvdimm@lfdr.de>; Fri,  3 May 2019 08:41:55 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B147721244A17;
	Thu,  2 May 2019 23:41:53 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 6F81E21959CB2
 for <linux-nvdimm@lists.01.org>; Thu,  2 May 2019 23:41:52 -0700 (PDT)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8CC3D2075E;
 Fri,  3 May 2019 06:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1556865712;
 bh=qAxjj5uiF5zEnzRbrg8NBWm/r/MITYyDqVpA7K94d04=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=T/xHj6l6GTULrzqty/QE9n+V3E7brgc1EE3YPacTpehUKVBEwYEB8Kjpj6eaNywET
 vOVTIu5pClz9D1ixUfyq2wi+fG23/JAt0fEXA4iWbz4fYGFM70dWGs3kIuIpiDPLE5
 z1ZErmGEyIuJkJ4kZlIVEyXnanSfyuAg225XdKNg=
Date: Fri, 3 May 2019 08:41:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v2 12/17] kunit: tool: add Python wrappers for running
 KUnit tests
Message-ID: <20190503064149.GB20723@kroah.com>
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-13-brendanhiggins@google.com>
 <20190502110220.GD12416@kroah.com>
 <CAFd5g47t=EdLKFCT=CnPkrM2z0nDVo24Gz4j0VxFOJbARP37Lg@mail.gmail.com>
 <a49c5088-a821-210c-66de-f422536f5b01@gmail.com>
 <CAFd5g44iWRchQKdJYtjRtPY6e-6e0eXpKXXsx5Ooi6sWE474KA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFd5g44iWRchQKdJYtjRtPY6e-6e0eXpKXXsx5Ooi6sWE474KA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
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
Cc: Petr Mladek <pmladek@suse.com>, linux-doc@vger.kernel.org,
 Amir Goldstein <amir73il@gmail.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Sasha Levin <Alexander.Levin@microsoft.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kselftest@vger.kernel.org,
 shuah@kernel.org, Rob Herring <robh@kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 Frank Rowand <frowand.list@gmail.com>, Knut Omang <knut.omang@oracle.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Felix Guo <felixguoxiuping@gmail.com>, wfg@linux.intel.com,
 Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>,
 Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 devicetree <devicetree@vger.kernel.org>, linux-kbuild@vger.kernel.org, "Bird,
 Timothy" <Tim.Bird@sony.com>, linux-um@lists.infradead.org,
 Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>,
 kunit-dev@googlegroups.com, Richard Weinberger <richard@nod.at>,
 Stephen Boyd <sboyd@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org,
 Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, May 02, 2019 at 04:45:29PM -0700, Brendan Higgins wrote:
> On Thu, May 2, 2019 at 2:16 PM Frank Rowand <frowand.list@gmail.com> wrote:
> >
> > On 5/2/19 11:07 AM, Brendan Higgins wrote:
> > > On Thu, May 2, 2019 at 4:02 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >>
> > >> On Wed, May 01, 2019 at 04:01:21PM -0700, Brendan Higgins wrote:
> > >>> From: Felix Guo <felixguoxiuping@gmail.com>
> > >>>
> > >>> The ultimate goal is to create minimal isolated test binaries; in the
> > >>> meantime we are using UML to provide the infrastructure to run tests, so
> > >>> define an abstract way to configure and run tests that allow us to
> > >>> change the context in which tests are built without affecting the user.
> > >>> This also makes pretty and dynamic error reporting, and a lot of other
> > >>> nice features easier.
> > >>>
> > >>> kunit_config.py:
> > >>>   - parse .config and Kconfig files.
> > >>>
> > >>> kunit_kernel.py: provides helper functions to:
> > >>>   - configure the kernel using kunitconfig.
> > >>>   - build the kernel with the appropriate configuration.
> > >>>   - provide function to invoke the kernel and stream the output back.
> > >>>
> > >>> Signed-off-by: Felix Guo <felixguoxiuping@gmail.com>
> > >>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > >>
> > >> Ah, here's probably my answer to my previous logging format question,
> > >> right?  What's the chance that these wrappers output stuff in a standard
> > >> format that test-framework-tools can already parse?  :)
> 
> To be clear, the test-framework-tools format we are talking about is
> TAP13[1], correct?

Yes.

> My understanding is that is what kselftest is being converted to use.

Yes, and I think it's almost done.  The core of kselftest provides
functions that all tests can use to log messages in the correct format.

The core of kunit should also log the messages in this format as well,
and not rely on the helper scripts as Frank points out, not everyone
will use/want them.  Might as well make it easy for everyone to always
do the right thing and not force it to always be added in later.

thanks,

greg k-h
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
