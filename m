Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B2C1E610
	for <lists+linux-nvdimm@lfdr.de>; Wed, 15 May 2019 02:27:00 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6A66F212777A5;
	Tue, 14 May 2019 17:26:59 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=207.54.116.67; helo=ale.deltatee.com;
 envelope-from=logang@deltatee.com; receiver=linux-nvdimm@lists.01.org 
Received: from ale.deltatee.com (ale.deltatee.com [207.54.116.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 6E801212777A5
 for <linux-nvdimm@lists.01.org>; Tue, 14 May 2019 17:26:58 -0700 (PDT)
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.89)
 (envelope-from <logang@deltatee.com>)
 id 1hQhkW-0003Ls-BO; Tue, 14 May 2019 18:26:25 -0600
To: Frank Rowand <frowand.list@gmail.com>,
 Brendan Higgins <brendanhiggins@google.com>
References: <20190509133551.GD29703@mit.edu>
 <ECADFF3FD767C149AD96A924E7EA6EAF9770D591@USCULXMSG01.am.sony.com>
 <875c546d-9713-bb59-47e4-77a1d2c69a6d@gmail.com>
 <20190509214233.GA20877@mit.edu>
 <b09ba170-229b-fde4-3e9a-e50d6ab4c1b5@deltatee.com>
 <20190509233043.GC20877@mit.edu>
 <8914afef-1e66-e6e3-f891-5855768d3018@deltatee.com>
 <6d6e91ec-33d3-830b-4895-4d7a20ba7d45@gmail.com>
 <3faa022b-0b70-0375-aa6d-12ea83a2671f@deltatee.com>
 <d148a554-2a71-a5a4-4bb2-d84d2c483277@gmail.com>
 <20190514083819.GC230665@google.com>
 <5ff098a9-9424-901c-9017-d4492e306528@gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <8c693b9f-43ec-8982-825c-cabfd61b659d@deltatee.com>
Date: Tue, 14 May 2019 18:26:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5ff098a9-9424-901c-9017-d4492e306528@gmail.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: wfg@linux.intel.com, rostedt@goodmis.org,
 rientjes@google.com, richard@nod.at, pmladek@suse.com, mpe@ellerman.id.au,
 khilman@baylibre.com, julia.lawall@lip6.fr, joel@jms.id.au, jdike@addtoit.com,
 daniel@ffwll.ch, dan.j.williams@intel.com, dan.carpenter@oracle.com,
 amir73il@gmail.com, Alexander.Levin@microsoft.com,
 linux-um@lists.infradead.org, linux-nvdimm@lists.01.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, kunit-dev@googlegroups.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, shuah@kernel.org,
 sboyd@kernel.org, robh@kernel.org, mcgrof@kernel.org,
 kieran.bingham@ideasonboard.com, keescook@google.com,
 gregkh@linuxfoundation.org, knut.omang@oracle.com, Tim.Bird@sony.com,
 tytso@mit.edu, brendanhiggins@google.com, frowand.list@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
 GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
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
 mpe@ellerman.id.au, linux-kselftest@vger.kernel.org, shuah@kernel.org,
 robh@kernel.org, linux-nvdimm@lists.01.org, khilman@baylibre.com,
 knut.omang@oracle.com, kieran.bingham@ideasonboard.com, wfg@linux.intel.com,
 joel@jms.id.au, rientjes@google.com, jdike@addtoit.com,
 dan.carpenter@oracle.com, devicetree@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org,
 rostedt@goodmis.org, julia.lawall@lip6.fr, kunit-dev@googlegroups.com,
 Theodore Ts'o <tytso@mit.edu>, richard@nod.at, sboyd@kernel.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, mcgrof@kernel.org,
 daniel@ffwll.ch, keescook@google.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>



On 2019-05-14 6:14 p.m., Frank Rowand wrote:
> The high level issue is to provide reviewers with enough context to be
> able to evaluate the patch series.  That is probably not very obvious
> at this point in the thread.  At this point I was responding to Logan's
> response to me that I should be reading Documentation to get a better
> description of KUnit features.  I _think_ that Logan thought that I
> did not understand KUnit features and was trying to be helpful by
> pointing out where I could get more information.  If so, he was missing
> my intended point had been that patch 0 should provide more information
> to justify adding this feature.

Honestly, I lost track of wait exactly your point was. And, in my
opinion, Brendan has provided over and above the information required to
justify Kunit's inclusion.

> One thing that has become very apparent in the discussion of this patch
> series is that some people do not understand that kselftest includes
> in-kernel tests, not just userspace tests.  As such, KUnit is an
> additional implementation of "the same feature".  (One can debate
> exactly which in-kernel test features kselftest and KUnit provide,
> and how much overlap exists or does not exist.  So don't take "the
> same feature" as my final opinion of how much overlap exists.)  So
> that is a key element to be noted and explained.

From my perspective, once we were actually pointed to the in-kernel
kselftest code and took a look at it, it was clear there was no
over-arching framework to them and that Kunit could be used to
significantly improve those tests with a common structure. Based on my
reading of the thread, Ted came to the same conclusion.

I don't think we should block this feature from being merged, and for
future work, someone can update the in-kernel kselftests to use the new
framework.

Logan
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
