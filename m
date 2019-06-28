Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF19359428
	for <lists+linux-nvdimm@lfdr.de>; Fri, 28 Jun 2019 08:23:30 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 517C1212AB4CD;
	Thu, 27 Jun 2019 23:23:29 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=batv+00426530c3eef8181159+5787+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 95AA2212AB4C4
 for <linux-nvdimm@lists.01.org>; Thu, 27 Jun 2019 23:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yaxzBZoKG5uqgp2Dc+YmYOZs72ahmoev192Hb8KX5XA=; b=ZJtWhwF7fqD1sZ4r3Cgz5Fs635
 QlZxV0jOHcqwp5SF6FmazJ9zJpJJPyTw2Fhy/KEBxh7ZDa5TStNMYqWsRNfrvxPQ8bwkdu8mRE8Q1
 kEaYQUG4Emmf0dh343oPASTBDots5mFNiXeyqXy5R2h952hAF5Izu4qKrR+Uv9rytgNwigNOTFP+T
 R3xzWMqRZlpvmTZPVNWS4oKXhsDCrD1ZWKY8B4EYh9HXKbhfw1Ia1SNZHZHa98EdI7haDhaSVcbrY
 bKGg35HjzvvkLbhk0QgNnuDgcGTxuEljFvnHfPSDdfNhfMJjEQvyS2/FBhW4PoYwW3OGbTnoXt6vw
 9+/HC09Q==;
Received: from 089144214055.atnat0023.highway.a1.net ([89.144.214.55]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1hgkIA-00011u-1J
 for linux-nvdimm@lists.01.org; Fri, 28 Jun 2019 06:23:26 +0000
Date: Fri, 28 Jun 2019 08:23:24 +0200
From: Christoph Hellwig <hch@infradead.org>
To: linux-nvdimm@lists.01.org
Subject: [ANNOUNCE] Alpine Linux Persistence and Storage Summit
Message-ID: <20190628062324.GE2014@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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

We proudly announce the second Alpine Linux Persistence and Storage
Summit (ALPSS), which will be held October 1st to October 4th 2019 at
the Lizumerhuette [1][2] in Austria .

The goal of this conference is to discuss the hot topics in Linux storage
and file systems, such as persistent memory, NVMe, Zoned Block Device,
and PCIe peer to peer transfers in a cool and relaxed setting with
spectacular views in the Austrian alps.

We plan to have a small selection of short and to the point talks with
lots of room for discussion in small groups, as well as ample downtime
to enjoy the surrounding.

Attendance is free except for the accommodation and food at the lodge [3],
but the number of seats is strictly limited.  If you are interested in
attending please reserve a seat by mailing your favorite topic(s) to:

	alpss-pc@lists.infradead.org

If you are interested in giving a short and crisp talk please also send
an abstract to the same address.

Note: The Lizumerhuette is an Alpine Society lodge in a high alpine
environment.  A hike of approximately 2 hours is required to the lodge,
and no other accommodations are available within walking distance.

More details will eventually be available on our website:

        http://www.alpss.at/

Thank you on behalf of the program committee:

    Stephen Bates
    Sagi Grimberg
    Christoph Hellwig
    Johannes Thumshirn
    Richard Weinberger

[1] http://www.tyrol.com/things-to-do/sports/hiking/refuge-huts/a-lizumer-hut
[2] https://www.glungezer.at/l-i-z-u-m-e-r-h-%C3%BC-t-t-e/
[3] approx. EUR 40-60 per person and night, depending on the room
    category
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
